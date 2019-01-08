$("#tabContainer").tabs({
    data: [{
        id: 'home',
        text: '控制台',
        url: "ControlPanel.aspx"
    }],
    showIndex: 0,
    loadAll: false
})
function AddNewTab(obj, tabId, pageId) {
    var tabUrl = "";
    if (tabId == "SiteParameters")
        tabUrl = "SysManage/SiteParameters.aspx";
    else if (tabId == "SysChannelList")
        tabUrl = "SysManage/SysChannelList.aspx";

    $("#tabContainer").data("tabs").addTab({ id: tabId, text: obj.innerText, closeable: true, url: tabUrl })
}