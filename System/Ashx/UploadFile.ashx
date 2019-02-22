<%@ WebHandler Language="C#" Class="UploadFile" %>

using System;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Collections;
using LitJson;

public class UploadFile : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/json";
        string[] extName = { ".jpg", ".gif", ".jpeg", ".png", ".pdf" };
        //输出的json字符串
        string result = "";
        //图片保存路径
        string _directory = "/images/upimg";
        //获取页面传过来的图片信息集合
        HttpFileCollection upload = HttpContext.Current.Request.Files;
        //文件输出对象
        FileViewOutput fileInfo = new FileViewOutput();
        //上传图片数量大于0，图片上传成功
        if (upload.Count > 0)
        {
            //获取上传的图片，只上传一张图片
            HttpPostedFile file = context.Request.Files[0];
            //获取图片名称并转小写
            string ext = Path.GetExtension(file.FileName).ToLower();
            if (!((IList)extName).Contains(ext))
            {
                fileInfo.Error = "请上传jpg、gif、jpeg、png、pdf格式文件";
                result = JsonMapper.ToJson(fileInfo);
                context.Response.Write(result);
            }
            if (file.InputStream.Length > 1024000) //1MB
            {
                fileInfo.Error = "上传的文件不要超过1MB";
                result = JsonMapper.ToJson(fileInfo);
                context.Response.Write(result);
            }
            string namefix = Guid.NewGuid().ToString() + "_" + DateTime.Now.ToString("HHmmss") + Path.GetExtension(file.FileName);
            string file_name = "/" + namefix;

            fileInfo.Url = _directory +"/"+ namefix;
            fileInfo.Name = file.FileName;
            //如果不存在就创建file文件夹
            if (System.IO.Directory.Exists(HttpContext.Current.Server.MapPath("~" + _directory)) == false)
            {
                System.IO.Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~" + _directory));
            }
            //保存图片
            file.SaveAs(HttpContext.Current.Server.MapPath("~" + _directory + file_name));
            result = JsonMapper.ToJson(fileInfo);
            context.Response.Write(result);
        }
        else 
        {
            fileInfo.Error = "请上传文件";
            result = JsonMapper.ToJson(fileInfo);
            context.Response.Write(result);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}

/// <summary>
/// 文件输出
/// </summary>
[Serializable]
public class FileViewOutput 
{
    //失败原因
    private string error;

    public string Error
    {
        get { return error; }
        set { error = value; }
    }

    //图片保存路径
    private string url;

    public string Url
    {
        get { return url; }
        set { url = value; }
    }

    //图片名称
    private string name;

    public string Name
    {
        get { return name; }
        set { name = value; }
    }
}