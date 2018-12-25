using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// 错误信息报文
/// </summary>
[Serializable]
public class Error
{
    public Error() { }
    /// <summary>
    /// 错误代码  （0：表示没有问题 ;1、2、3等表示其他问题）
    /// </summary>
    private string errorCode;

    public string ErrorCode
    {
        get
        {
            return this.errorCode;
        }

        set
        {
            this.errorCode = value;
        }
    }
    /// <summary>
    /// 错误的原因
    /// </summary>
    private string errorMsg;
    public string ErrorMsg
    {
        get
        {
            return this.errorMsg;
        }

        set
        {
            this.errorMsg = value;
        }
    }

    private List<Error> errors;
    public List<Error> Errors
    {
        get
        {
            return this.errors;
        }

        set
        {
            this.errors = value;
        }
    }
}

/// <summary>
/// 服务器信息
/// </summary>
[Serializable]
public class ServerInfo
{
    public ServerInfo() { }
    /// <summary>
    /// 服务器名称
    /// </summary>
    private string serName;

    public string SerName
    {
        get { return serName; }
        set { serName = value; }
    }
    /// <summary>
    /// 服务器Id
    /// </summary>
    private string serIp;

    public string SerIp
    {
        get { return serIp; }
        set { serIp = value; }
    }
    /// <summary>
    /// 服务器NET框架版本
    /// </summary>
    private string serFrame;

    public string SerFrame
    {
        get { return serFrame; }
        set { serFrame = value; }
    }
    /// <summary>
    /// 服务器操作系统
    /// </summary>
    private string serSystem;

    public string SerSystem
    {
        get { return serSystem; }
        set { serSystem = value; }
    }
    /// <summary>
    /// 服务器IIS环境
    /// </summary>
    private string serEnvir;

    public string SerEnvir
    {
        get { return serEnvir; }
        set { serEnvir = value; }
    }
    /// <summary>
    /// 服务器端口
    /// </summary>
    private string serPort;

    public string SerPort
    {
        get { return serPort; }
        set { serPort = value; }
    }
    /// <summary>
    /// 虚拟目录绝对路径
    /// </summary>
    private string serPath;

    public string SerPath
    {
        get { return serPath; }
        set { serPath = value; }
    }
    /// <summary>
    /// HTTPS支持
    /// </summary>
    private string serHttp;

    public string SerHttp
    {
        get { return serHttp; }
        set { serHttp = value; }
    }
    /// <summary>
    /// seesion总数
    /// </summary>
    private string serSessionCount;

    public string SerSessionCount
    {
        get { return serSessionCount; }
        set { serSessionCount = value; }
    }
}

/// <summary>
/// 网站参数信息
/// </summary>
[Serializable]
public class WebParamInfo 
{
    /// <summary>
    /// 网站标题
    /// </summary>
    private string _webName;

    public string WebName
    {
        get { return _webName; }
        set { _webName = value; }
    }

    /// <summary>
    /// 网站关键字
    /// </summary>
    private string _webKey;

    public string WebKey
    {
        get { return _webKey; }
        set { _webKey = value; }
    }

    /// <summary>
    /// 网站描述
    /// </summary>
    private string _webDescribe;

    public string WebDescribe
    {
        get { return _webDescribe; }
        set { _webDescribe = value; }
    }

    /// <summary>
    /// 网站版权
    /// </summary>
    private string _webCopyRight;

    public string WebCopyRight
    {
        get { return _webCopyRight; }
        set { _webCopyRight = value; }
    }

}

/// <summary>
/// 导航栏频道信息
/// </summary>
[Serializable]
public class News_Class 
{
    /// <summary>
    /// id
    /// </summary>
    private int _id;

    public int id
    {
        get { return _id; }
        set { _id = value; }
    }

    /// <summary>
    /// 名称
    /// </summary>
    private string _sort_name;

    public string sort_name
    {
        get { return _sort_name; }
        set { _sort_name = value; }
    }

    /// <summary>
    /// 父级id
    /// </summary>
    private int _big_id;

    public int big_id
    {
        get { return _big_id; }
        set { _big_id = value; }
    }

    /// <summary>
    /// 分类路径 格式为：（,0,1）-英文逗号+数字+英文逗号+数字+...
    /// </summary>
    private string _path;

    public string path
    {
        get { return _path; }
        set { _path = value; }
    }

    /// <summary>
    /// 名称（英文名字）
    /// </summary>
    private string _sort_name_en;

    public string sort_name_en
    {
        get { return _sort_name_en; }
        set { _sort_name_en = value; }
    }

    /// <summary>
    /// 优先级别
    /// </summary>
    private int _orders;

    public int orders
    {
        get { return _orders; }
        set { _orders = value; }
    }

    /// <summary>
    /// 是否停用
    /// </summary>
    private bool _istop;

    public bool istop
    {
        get { return _istop; }
        set { _istop = value; }
    }

    /// <summary>
    /// 页面标题
    /// </summary>
    private string _pagetitle;

    public string pagetitle
    {
        get { return _pagetitle; }
        set { _pagetitle = value; }
    }

    /// <summary>
    /// 页面关键字
    /// </summary>
    private string _pagekeyw;

    public string pagekeyw
    {
        get { return _pagekeyw; }
        set { _pagekeyw = value; }
    }

    /// <summary>
    /// 页面描述
    /// </summary>
    private string _pagedesc;

    public string pagedesc
    {
        get { return _pagedesc; }
        set { _pagedesc = value; }
    }

    /// <summary>
    /// 栏目描述
    /// </summary>
    private string _sort_desc;

    public string sort_desc
    {
        get { return _sort_desc; }
        set { _sort_desc = value; }
    }

    /// <summary>
    /// 图片路径
    /// </summary>
    private string _picpath;

    public string picpath
    {
        get { return _picpath; }
        set { _picpath = value; }
    }

    /// <summary>
    /// 
    /// </summary>
    private bool _isright;

    public bool isright
    {
        get { return _isright; }
        set { _isright = value; }
    }

    /// <summary>
    /// 类型
    /// </summary>
    private int _type;

    public int type
    {
        get { return _type; }
        set { _type = value; }
    }
}