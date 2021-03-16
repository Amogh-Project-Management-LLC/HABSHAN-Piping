<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SelectionPage.aspx.cs" Inherits="SelectionPage_data" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement && window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }
        function CloseModal() {
            // GetRadWindow().close();
            setTimeout(function () {
                GetRadWindow().close();
            }, 0);
        }
    </script>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table id="table1" style="padding: 10px">
                <tr>

                    <td>
                        <telerik:RadButton ID="btnSave" runat="server" Text="Save & Close" OnClick="btnSave_Click" Width="120px"></telerik:RadButton>

                    </td>


                </tr>
            </table>
            <table id="table2" style="padding: 10px">
                <tr>
                    <td>
                        <asp:PlaceHolder ID="PlHolder" runat="server"></asp:PlaceHolder>

                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="SheetDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT SEQ, REPORT_NAME FROM  SHEET_WISE_DOWNLOAD WHERE EXPT_ID=:EXPT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="EXPT_ID" QueryStringField="EXPT_ID" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>





