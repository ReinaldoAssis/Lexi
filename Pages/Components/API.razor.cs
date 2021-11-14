using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using static OpenManga.Pages.Mangas;
using HtmlAgilityPack;
using Gehtsoft.PDFFlow;
using Gehtsoft.PDFFlow.Builder;
using Gehtsoft.PDFFlow.Models.Enumerations;

namespace Backend
{
    interface IBackend
    {
        void DownloadManga(DataManga manga, string download_volume);
    }
    
    public partial class Backend : IBackend
    {
        public async void DownloadManga(DataManga manga, string download_volume)
        {

            //gets a dictionary with the page index and it's respective string url to the image
            var url_list = await DownloadManga_ScrapPageForImageSrc(manga, download_volume);
            //downloads all images from the urls above async
            var all_images_downloaded = await DownloadAllImagesAsync(url_list);
            //appends image's bytes to pdf page and outputs the file
            ConvertToPdf(all_images_downloaded,manga.download_folder+'\\'+manga.name+".pdf");
            Console.WriteLine("ITS COMPLETE!");
            
        }

        public async Task<Dictionary<int,string>> DownloadManga_ScrapPageForImageSrc(DataManga manga, string download_volume)
        {

            Dictionary<int, string> retorno = new Dictionary<int, string>();

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
                
                Console.WriteLine(_final ?? "img src is null");

                retorno.Add(index,_final);
                    
            });

            return retorno;
        }

        byte[] DownloadImageFromURL(string url)
        {
            using (var client = new WebClient())
            {
                return client.DownloadData(url);
            }
        }

        async Task<Dictionary<int, byte[]>> DownloadAllImagesAsync(Dictionary<int, string> url_list)
        {
            Dictionary<int, byte[]> image_list = new Dictionary<int, byte[]>();
            Parallel.ForEach(url_list, item =>
            {
                image_list.Add(item.Key,DownloadImageFromURL(item.Value));
            });

            return image_list;
        }
        
        void ConvertToPdf(Dictionary<int,byte[]> url_list, string outputpath)
        {
            var doc = DocumentBuilder.New();
            foreach (var page in url_list)
            {
                doc.AddSection().SetMargins(0).SetOrientation(PageOrientation.Portrait).AddImage(page.Value).SetScale(ScalingMode.Stretch).SetAlignment(HorizontalAlignment.Center);
            }
            doc.Build(outputpath);
        }
        
        
    }
}