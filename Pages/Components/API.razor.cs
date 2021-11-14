using System;
using static OpenManga.Pages.Mangas;
using HtmlAgilityPack;

namespace Backend
{
    interface IBackend
    {
        string DownloadManga(DataManga manga, string download_volume);
    }
    
    public partial class Backend : IBackend
    {
        public string DownloadManga(DataManga manga, string download_volume)
        {
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
            
            Console.WriteLine("VOLUME FORMAT -> "+manga.volume_NumberFormat);
            
            //gets the url from manga, [volume] is replaced by current volume to download
            string url = manga.baseurl.Replace("[volume]", "" + download_volume, StringComparison.OrdinalIgnoreCase);
            Console.WriteLine("DOWNLOAD -> "+url);
            
            //TODO: check if format is passed
            string _pageNumber = "1";
            if (manga.img_NumberFormat != null)
            {
                _pageNumber = int.Parse(_pageNumber).ToString(manga.img_NumberFormat);
            }
            
            
            //complete url, [page] is replaced by current downloading page
            var html = url.Replace("[page]", _pageNumber, StringComparison.OrdinalIgnoreCase);
            
            HtmlWeb web = new HtmlWeb();
            //gets the html page
            HtmlDocument htmlpage = web.Load(html);
            
            Console.WriteLine("Url -> "+html);

            HtmlNode img;
            
            if (manga.img_class != null || manga.img_class != "") img = htmlpage.DocumentNode.SelectSingleNode($"//img[contains(@class,'{manga.img_class}')]");
            else img = htmlpage.DocumentNode.SelectSingleNode("//img");
            
            //Console.WriteLine("html -> "+htmlpage.Text);
            Console.WriteLine(img.Name ?? "Img is null");
            Console.WriteLine(img.Attributes["src"].Value ?? "img src is null");

            //Console.WriteLine(img.Attributes["src"].Value);
            
            
            return "0";
        }
    }
}