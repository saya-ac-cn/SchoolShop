var navs = [{
	"title" : "平台总览",
	"icon" : "icon-computer",
	"href" : "page/main.html",
	"spread" : false
},{
	"title" : "个人信息",
	"icon" : "&#xe61c;",
	"href" : "/admin/info.html",
	"spread" : false
},{
    "title" : "审核商户",
    "icon" : "&#xe631;",
    "href" : "/admin/reviewShop.html",
    "spread" : false
},{
    "title" : "管理摊位",
    "icon" : "&#xe61c;",
    "href" : "/admin/manaStand.html",
    "spread" : false
},{
    "title" : "管理用户",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "管理会员",
            "icon" : "&#xe631;",
            "href" : "/shop/shopinfo.html",
            "spread" : false
        },
        {
            "title" : "管理商家",
            "icon" : "&#xe631;",
            "href" : "/shop/pictureMana.html",
            "spread" : false
        }
    ]
},{
    "title" : "综合管理",
    "icon" : "&#xe61c;",
    "href" : "",
    "spread" : false,
    "children" : [
        {
            "title" : "发布动态",
            "icon" : "&#xe631;",
            "href" : "/shop/addGoods.html",
            "spread" : false
        },
        {
            "title" : "管理动态",
            "icon" : "&#xe631;",
            "href" : "/shop/modifyGoods.html",
            "spread" : false
        }
    ]
},]