<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolTransSelect.aspx.cs" Inherits="SpoolMove_SpoolTransSelect" Title="Spool Activity" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="width:100%">
        <table style="background-color: gainsboro; padding: 4px; width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnContinue" runat="server" Text="Continue" Width="80" OnClick="btnContinue_Click"></telerik:RadButton>
                </td>
                <%--<td>
                    <telerik:RadButton ID="btnUpdateSpools" runat="server" Text="Update" Width="80" OnClick="btnUpdateSpools_Click"></telerik:RadButton>
                </td>--%>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke; padding: 3px; margin: 3px; border-radius: 5px;width:100%">
    </div>
    <div style="width:100%">
        <%--<telerik:RadListBox ID="transCatList2" runat="server" DataSourceID="TransCatDataSource"
            DataTextField="TRANS_CAT" DataValueField="CAT_ID" OnDataBound="transCatList_DataBound" AppendDataBoundItems="true">
        </telerik:RadListBox>--%>
        <asp:RadioButtonList ID="transCatList" runat="server" DataSourceID="TransCatDataSource"
            DataTextField="TRANS_CAT" DataValueField="CAT_ID" OnDataBound="transCatList_DataBound" AppendDataBoundItems="true">
        </asp:RadioButtonList>
    </div>
    <asp:SqlDataSource ID="TransCatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT CAT_ID, ROWNUM||'. '||TRANS_CAT AS TRANS_CAT FROM (SELECT CAT_ID,TRANS_CAT FROM PIP_SPOOL_TRANS_CAT WHERE PROJ_ENABLE = 'Y' ORDER BY ORDER_A)">
    </asp:SqlDataSource>
</asp:Content>
