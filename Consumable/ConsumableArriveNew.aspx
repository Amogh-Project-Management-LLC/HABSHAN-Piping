<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="ConsumableArriveNew.aspx.cs" Inherits="Consumable_ConsumableArriveNew" Title="Consumable * New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="padding-left: 10px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table style="width: 100%">
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Arrived Date</td>
                    <td>
                        <telerik:RadDatePicker ID="txtArrivedDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        </telerik:RadDatePicker>
                        <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtArrivedDate" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>

                    <td style="width: 150px; background-color: Gainsboro;">Category</td>
                    <td>
                        <asp:DropDownList ID="ddCategory" runat="server" AppendDataBoundItems="True"
                            DataSourceID="Category_SqlDataSource" DataTextField="CATEGORY" DataValueField="CAT_ID" Width="200px" AutoPostBack="True">
                            <asp:ListItem Selected="True" Text="" Value="-1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Item Code</td>
                    <td>
                        <asp:DropDownList ID="ddItemCode" runat="server" AppendDataBoundItems="True" DataSourceID="ItemCode_SqlDataSource" DataTextField="MAT_CODE" DataValueField="MAT_ID" Width="200px" OnDataBinding="ddItemCode_DataBinding">
                        </asp:DropDownList>
                        <asp:CompareValidator ID="ndetypeValidator" runat="server" ControlToValidate="ddCategory" ErrorMessage="*" ForeColor="Red" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Qty</td>
                    <td>
                        <asp:TextBox ID="txtQty" runat="server" Width="60px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="QtyValidator" runat="server" ControlToValidate="txtQty"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="ItemCode_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_ID, MAT_CODE FROM CONSUMABLE_MASTER WHERE (CAT_ID = :CAT_ID) AND (PROJECT_ID = :PROJECT_ID) ORDER BY MAT_CODE'>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddCategory" DefaultValue="-1" Name="CAT_ID" PropertyName="SelectedValue" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="UOM_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT UNIT_ID, UOM FROM UOM_DESCR ORDER BY UOM'></asp:SqlDataSource>

    <asp:SqlDataSource ID="Category_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT CAT_ID, CATEGORY FROM CONSUMABLE_CATEGORY ORDER BY CATEGORY'></asp:SqlDataSource>
</asp:Content>