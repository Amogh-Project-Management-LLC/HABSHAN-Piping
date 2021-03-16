<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_TransSelect.aspx.cs" Inherits="TestPkg_TransSelect" Title="Test Package Transmittal" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnContinue" runat="server" OnClick="btnContinue_Click" Text="Continue" Width="86px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                Select the transmittal below:
            </td>
        </tr>
        <tr>
            <td>
                <img src="../Images/thingraditent.png" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:RadioButtonList ID="transCatList" runat="server" DataSourceID="TransCatDataSource"
                    DataTextField="TRANS_TYPE" DataValueField="TYPE_ID" Width="480px" 
                    ondatabound="transCatList_DataBound">
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="TransCatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT * FROM TPK_TRANS_TYPE WHERE PROJECT_ID = :PROJECT_ID'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
