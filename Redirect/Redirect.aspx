<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="Redirect.aspx.cs" Inherits="Redirect_Code" Title="Piping Loading....." %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="z-index: 1000;text-align: center; height:400px;">
        <img id="imgAjax" alt="loading..." title="loading..." src="../images/ajax-loading.gif" style="position: absolute; top: 25%; left: 43%; padding: 10px; z-index: 1001;width: 100px; height: 100px;z-index: 1001;" /><br />
        <br />
    </div>
    <script type="text/javascript">
        /* <![CDATA[ */
        this.focus(); //focus on new window

        redirect = function () {
            var querystring = window.location.search.substring(1); //first query string
            var page = querystring.substring(querystring.indexOf('=') + 1, querystring.length);
            function toPage() {
                if (page !== undefined && page.length > 1) {
                    document.write('<!--[if !IE]>--><head><meta http-equiv="REFRESH" content="0;url=' + page + '" /><\/head><!--<![endif]-->');
                    document.write(' \n <!--[if IE]>');
                    document.write(' \n <script type="text/javascript">');
                    document.write(' \n var version = parseInt(navigator.appVersion);');
                    document.write(' \n if (version>=4 || window.location.replace) {');
                    document.write(' \n window.location.replace("' + page + '");');
                    document.write(' document.images["imgAjax"].src = "../images/ajax-loading.gif"');
                    document.write(' \n } else');
                    document.write(' \n window.location.href="' + page + '";');
                    document.write(' \n  <\/script> <![endif]-->');
                }
            }
            return {
                begin: toPage
            }
        }();

        redirect.begin();

        /* ]]> */
    </script>
</asp:Content>
