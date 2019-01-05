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
    $("#tabContainer").data("tabs").addTab({ id: tabId, text: obj.innerText, closeable: true, url: 'SysManage/SiteParameters.aspx' })
}