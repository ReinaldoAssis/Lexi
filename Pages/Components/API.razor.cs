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
            
            public int Volume { get; set; }
            
            public MangaPage(){}

            public MangaPage(string _url, int _index, DataManga manga, int volume)
            {
                Index = _index;
                Url = _url;
                Volume = volume;
                Parent = manga;
            }

            public MangaPage(string _url, int _index, string temp, int volume)
            {
                Index = _index;
                Url = _url;
                Volume = volume;
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
            var url_list = await DownloadManga_ScrapPageForImageSrc(manga);
            //downloads all images from the urls above async
            var all_images_downloaded = await DownloadAllImagesInTempAsync(url_list);
            
            //appends image's bytes to pdf page and outputs the file
            
            ConvertToPdfFromTempFiles(all_images_downloaded,manga);

        }

        public async Task<List<MangaPage>> DownloadManga_ScrapPageForImageSrc(DataManga manga)
        {

            List<MangaPage> retorno = new List<MangaPage>();

            string[] _rangeSpl =  (manga.download_PageRange ?? "").Split('-') ?? new []{"0",""};
            int start_page = 0;
            int end_page = -1;

            int repeat = 1; //download sequence of volumes ex. 10 for downloading current volume to currente volue +10
            try
            {
                start_page = int.Parse(_rangeSpl[0]); //try parse a range for downloading pages from manga's volume
                end_page = int.Parse(_rangeSpl[1]);
                repeat = int.Parse(manga.download_Repeat);

            } catch{}


            //Checks for custom volume number format
            manga.volume_NumberFormat = manga.volume_NumberFormat ?? "D1";
            
            //gets the url from manga, [volume] is replaced by current volume to download

            Parallel.For(0, repeat, v =>
            {
                string url = GetReplacedUrl(manga.baseurl, "volume", manga.lastread+v, manga.volume_NumberFormat);
                Print($"Downloading volume {v}");
                Parallel.For(start_page, end_page == -1 ? 20 : end_page, index =>
                { //TODO: change default non defined max search page number
                    
                    index += 1;

                    //TODO: check if format is passed
                    manga.img_NumberFormat = manga.img_NumberFormat ?? "D1";

                    //complete url, [page] is replaced by current downloading page
                    var html = GetReplacedUrl(url, "page", index,
                        manga.img_NumberFormat); //url.Replace("[page]", _pageNumber, StringComparison.OrdinalIgnoreCase);
                    Print(html);

                    HtmlWeb web = new HtmlWeb();
                    //gets the html page
                    HtmlDocument htmlpage = web.Load(html);

                    HtmlNode img;

                    if (manga.img_class != null || manga.img_class != "")
                        img = htmlpage.DocumentNode.SelectSingleNode($"//img[contains(@class,'{manga.img_class}')]");
                    else img = htmlpage.DocumentNode.SelectSingleNode("//img");

                    string _final = null;
                    if (html.Contains(".jpg"))//checks if url goes direct to an .jpg image
                    {
                        _final = html;
                    }
                    else
                    {
                        try
                        {
                            _final = img.Attributes["src"].Value;
                        }
                        catch(Exception e)
                        {
                            Console.WriteLine(e);
                            _final = null;
                        }
                    }

                    if (_final != null) retorno.Add(new MangaPage(_final, index, manga, manga.lastread+v));

                });


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

        string GetReplacedUrl(string url, string tag, int index, string format)
        {
            return url.Replace($"[{tag}]", index.ToString(format), StringComparison.OrdinalIgnoreCase);
        }

        async Task<List<MangaPage>> DownloadAllImagesInTempAsync(List<MangaPage> url_list) //download all images to temporary path
        {
            List<MangaPage> image_list = new List<MangaPage>(); //list to store the updated manga's page
            Parallel.ForEach(url_list, item =>
            {
                string tempPath = item.Parent.download_folder+"\\"+$"{item.Volume}_{item.Index}.jpg"; //Path.GetTempFileName(); //temporary path to image
                DownloadImageFromURLToTempFile(item.Url,tempPath); //downloads image to temp path

                //the new manga page object has an image url on the internet, an index representing it's position and a temporary path where the image is stored
                image_list.Add(new MangaPage(item.Url, item.Index, tempPath, item.Volume));
            });

            return image_list;
        }
        
        async void TempFilesCleanup(List<MangaPage> mangapages)
        {
            foreach (var manga in mangapages)
            {
                for (int i = 0; i < 6; i++)
                {
                    try
                    {
                        var file = new FileInfo(manga.tempPath);
                        // Console.WriteLine("Cleaning "+file.Name+" from temp");
                        file.Delete();
                    }
                    catch
                    {
                        await Task.Delay(200);
                    }
                }
            }
        }

        async void ConvertToPdfFromTempFiles(List<MangaPage> mangas, DataManga manga)
        {
            Encoding.RegisterProvider(CodePagesEncodingProvider.Instance);
            PdfDocument doc = new PdfDocument();
            doc.Info.Title = manga.name;
            mangas = mangas.OrderBy(x => x.Volume).ThenBy(x => x.Index).ToList();
            string output = manga.download_folder + '\\' + manga.name + ".pdf";
            
            const int timesToTry = 5;
            bool force_stop = false;
            
            foreach (var metaPage in mangas)
            {
                //await Task.Delay(700);
                //Print("Trying to add page "+metaPage.Index+" | "+metaPage.tempPath);
                PdfPage pdfPage = doc.AddPage();
                for (int t = 0; t < timesToTry+1; t++)
                {
                    if (force_stop) break;
                    
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
                                graphics.DrawImage(img,0,0,img.PixelWidth,img.PixelHeight);
                                graphics.Dispose();
                                //doc.InsertPage(metaPage.Index, pdfPage);
                            }
                        }
            
                        break;
            
                    }
                    catch (Exception e)
                    {
                        if (t == timesToTry)
                        {
                            
                            Print($"Failed to add page {metaPage.Index}");
                            Console.WriteLine(e);
                            force_stop = true;
                        }
                        await Task.Delay(600);
                    }
                    
                }
            }
            
            doc.Save(output);
            //TempFilesCleanup(mangas);
            Console.WriteLine("ITS COMPLETE!");

        }
        
        static void Print(string value) {Console.WriteLine(value);} 
   
        
    }
}