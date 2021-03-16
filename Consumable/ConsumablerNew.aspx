<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="ConsumablerNew.aspx.cs" Inherits="Manpower_ManpowerNew" Title="Consumable * New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="padding-left: 10px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table style="width: 100%">
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Item Code/ Symbol</td>
                    <td>
                        <asp:TextBox ID="txtSymbol" runat="server" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="SymbolValidator" runat="server" ControlToValidate="txtSymbol"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" runat="server" Width="500px"></asp:TextBox>
                    </td>
                </tr>
                <tr>

                    <td style="width: 150px; background-color: Gainsboro;">Category</td>
                    <td>
                        <asp:DropDownList ID="ddCategory" runat="server" AppendDataBoundItems="True" DataSourceID="Category_SqlDataSource"
                            DataTextField="CATEGORY" DataValueField="CAT_ID" Width="200px">
                            <asp:ListItem Selected="True" Value="-1" Text=""></asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="ndetypeValidator" runat="server" ControlToValidate="ddCategory"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">UOM</td>
                    <td>
                        <asp:DropDownList ID="ddUOM" runat="server" AppendDataBoundItems="True" DataSourceID="UOM_SqlDataSource"
                            DataTextField="UOM" DataValueField="UNIT_ID" Width="100px">
                            <asp:ListItem Selected="True" Value="-1" Text=""></asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="UOM_CompareValidator" runat="server" ControlToValidate="ddUOM"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>

                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="Category_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT CAT_ID, CATEGORY FROM CONSUMABLE_CATEGORY ORDER BY CATEGORY'></asp:SqlDataSource>

    <asp:SqlDataSource ID="UOM_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT UNIT_ID, UOM FROM UOM_DESCR ORDER BY UOM'></asp:SqlDataSource>
</asp:Content>