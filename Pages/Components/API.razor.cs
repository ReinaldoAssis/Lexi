using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using static OpenManga.Pages.Mangas;
using HtmlAgilityPack;
using Gehtsoft.PDFFlow;
using Gehtsoft.PDFFlow.Builder;
using Gehtsoft.PDFFlow.Models.Enumerations;
using Gehtsoft.PDFFlow.Models.Shared;
using PdfSharp;
using PdfSharp.Drawing;
using PdfSharp.Pdf;

namespace Backend
{

    
    interface IBackend
    {
        void DownloadManga(DataManga manga, string download_volume);
    }
    
    public partial class Backend : IBackend
    {
        public class MangaPage
        {
            public byte[] Content { get; set; }
            public string Url { get; set; }
            public int Index { get; set; }
            public float[] Size { get; set; } = new float[2];
            
            public DataManga Parent { get; set; }
            
            public string tempPath { get; set; }
            
            public MangaPage(){}

            public MangaPage(string _url, int _index, DataManga manga=null)
            {
                Index = _index;
                Url = _url;
                Parent = manga;
            }

            public MangaPage(string _url, int _index, string temp)
            {
                Index = _index;
                Url = _url;
                tempPath = temp;
            }
            
            public MangaPage(string _url, int _index, string temp, byte[] content)
            {
                Index = _index;
                Url = _url;
                tempPath = temp;
                Content = content;
            }
            
            public MangaPage(string _url, int _index, byte[] _content, float[] _size)
            {
                Index = _index;
                Url = _url;
                Size = _size;
                Content = _content;
            }
            //sets the parent for this page, in this case the manga that it belongs to
        }
        
        public async void DownloadManga(DataManga manga, string download_volume)
        {

            //gets a dictionary with the page index and it's respective string url to the image
            var url_list = await DownloadManga_ScrapPageForImageSrc(manga, download_volume);
            //downloads all images from the urls above async
            var all_images_downloaded = await DownloadAllImagesInTempAsync(url_list);
            //appends image's bytes to pdf page and outputs the file
            ConvertToPdfFromTempFiles(all_images_downloaded,manga);
            Console.WriteLine("ITS COMPLETE!");
            
        }

        public async Task<List<MangaPage>> DownloadManga_ScrapPageForImageSrc(DataManga manga, string download_volume)
        {

            List<MangaPage> retorno = new List<MangaPage>();

            string[] _rangeSpl =  (manga.download_range ?? "").Split('-') ?? new []{"",""};
            int start_page;
            int end_page;
            try
            {
                start_page = int.Parse(_rangeSpl[0]);
                end_page = int.Parse(_rangeSpl[1]);
            }catch{}
            
            //Checks for custom volume number format

            if (manga.volume_NumberFormat != null && manga.volume_NumberFormat != "")
                download_volume = int.Parse(download_volume).ToString(manga.volume_NumberFormat);
            
            //gets the url from manga, [volume] is replaced by current volume to download
            string url = manga.baseurl.Replace("[volume]", "" + download_volume, StringComparison.OrdinalIgnoreCase);
            

            Parallel.For(0, 20, index =>
            {
                index += 1;
                
                //TODO: check if format is passed
                string _pageNumber = index.ToString();
                
                
                
                if (manga.img_NumberFormat != null)
                {
                    _pageNumber = int.Parse(_pageNumber).ToString(manga.img_NumberFormat);
                }
                
                
                //complete url, [page] is replaced by current downloading page
                var html = url.Replace("[page]", _pageNumber, StringComparison.OrdinalIgnoreCase);
                
                HtmlWeb web = new HtmlWeb();
                //gets the html page
                HtmlDocument htmlpage = web.Load(html);
                
                HtmlNode img;
                
                if (manga.img_class != null || manga.img_class != "") img = htmlpage.DocumentNode.SelectSingleNode($"//img[contains(@class,'{manga.img_class}')]");
                else img = htmlpage.DocumentNode.SelectSingleNode("//img");

                string _final = img.Attributes["src"].Value;

                retorno.Add(new MangaPage(_final, index, manga));

            });

            return retorno;
        }

        void DownloadImageFromURLToTempFile(string url, string path)
        {
            using (var client = new WebClient())
            {
                client.DownloadFileAsync(new Uri(url),path);
                client.Dispose();
            }
        }

        async Task<List<MangaPage>> DownloadAllImagesInTempAsync(List<MangaPage> url_list) //download all images to temporary path
        {
            List<MangaPage> image_list = new List<MangaPage>(); //list to store the updated manga's page
            Parallel.ForEach(url_list, item =>
            {
                string tempPath = item.Parent.download_folder+"\\"+item.Index+".jpg"; //Path.GetTempFileName(); //temporary path to image
                DownloadImageFromURLToTempFile(item.Url,tempPath); //downloads image to temp path

                //the new manga page object has an image url on the internet, an index representing it's position and a temporary path where the image is stored
                image_list.Add(new MangaPage(item.Url, item.Index, tempPath));
            });

            return image_list;
        }
        
        void TempFilesCleanup(List<MangaPage> mangapages)
        {
            foreach (var manga in mangapages)
            {
                var file = new FileInfo(manga.tempPath);
                Console.WriteLine("Cleaning "+file.Name+" from temp");
                file.Delete();
            }
        }

        async void ConvertToPdfFromTempFiles(List<MangaPage> mangas, DataManga manga)
        {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            PdfDocument doc = new PdfDocument();
            doc.Info.Title = manga.name;
            mangas = mangas.OrderBy(x => x.Index).ToList();
            string output = manga.download_folder + '\\' + manga.name + ".pdf";

            foreach (var metaPage in mangas)
            {
                //await Task.Delay(700);
                Print("Trying to add page "+metaPage.Index+" | "+metaPage.tempPath);
                PdfPage pdfPage = doc.AddPage();
                for (int t = 0; t < 6; t++)
                {
                    try
                    {
                        using (FileStream fs = new FileStream(metaPage.tempPath, FileMode.Open, FileAccess.Read))
                        {
                            using (XImage img = XImage.FromStream(fs))
                            {
                                pdfPage.Width = img.PixelWidth;
                                pdfPage.Height = img.PixelHeight;
                                //XImage img = XImage.FromFile(metaPage.tempPath); //TODO: implement pdf generation with pdfsharp
                                XGraphics graphics = XGraphics.FromPdfPage(pdfPage);
                                graphics.DrawImage(img,0,0);
                                graphics.Dispose();
                                //doc.InsertPage(metaPage.Index, pdfPage);
                            }
                        }
            
                        break;
            
                    }
                    catch (Exception e)
                    {
                        Print($"AGAIN trying index {metaPage.Index} for {t} time");
                        Console.WriteLine(e);
                        await Task.Delay(300);
                    }
                    
                }
            }
            
            doc.Save(output);

        }
        
        static void Print(string value) {Console.WriteLine(value);} 
   
        
    }
}