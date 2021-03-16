<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingJCNew.aspx.cs" Inherits="SpoolMove_SpoolCoatingJCNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
            height: 20px;
        }
    </style>
    <table>
        <tr>
            <td class="Heading">Job Card No</td>
            <td>
                <telerik:RadTextBox ID="txtJCNo" runat="server" Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td class="Heading">Issue Date</td>
            <td>
                <telerik:RadDatePicker ID="txtIssueDate" runat="server" Width="150px" DateInput-DisplayDateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Target Date</td>
            <td>
                <telerik:RadDatePicker ID="txtTargetDate" runat="server" Width="150px" DateInput-DisplayDateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
            </td>
        </tr>
        <tr>
            <td class="Heading">Coating Vendor</td>
            <td>
                <telerik:RadDropDownList ID="ddlCoatingVendor" runat="server" Width="200px" DataSourceID="sqlCoatingVendor" DataTextField="SUB_CON_NAME"
                    DataValueField="SUB_CON_ID" DropDownHeight="100px" DropDownWidth="200px" OnDataBinding="ddlCoatingVendor_DataBinding"
                    AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlCoatingVendor_SelectedIndexChanged">
                </telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Heading">From Subcon</td>
            <td>
                <telerik:RadDropDownList ID="ddlFromSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="sqlFromVendor" 
                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBinding="ddlFromSubcon_DataBinding"
                    OnSelectedIndexChanged="ddlFromSubcon_SelectedIndexChanged" AutoPostBack="true"></telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Heading">Coating Type</td>
            <td>
                <telerik:RadDropDownList ID="ddlCoatingType" runat="server" Width="200px" DataSourceID="sqlCoatingType" DataTextField="COATING_TYPE"
                    DataValueField="COATING_TYPE_ID" DropDownHeight="100px" DropDownWidth="200px" OnDataBinding="ddlCoatingType_DataBinding"
                    AppendDataBoundItems="true">
                </telerik:RadDropDownList>
            </td>
        </tr>
         <tr>
            <td class="Heading">Coating Category</td>
            <td>
                <telerik:RadDropDownList ID="ddlCoatingCat" runat="server" Width="200px" DropDownWidth="200px">
                    <Items>
                        <telerik:DropDownListItem Text="(Select)" Value="" />
                        <telerik:DropDownListItem Text="INTERNAL" Value="INTERNAL" />
                        <telerik:DropDownListItem Text="EXTERNAL" Value="EXTERNAL" />
                        <telerik:DropDownListItem Text="INTERNAL & EXTERNAL" Value="INTERNAL & EXTERNAL" />
                    </Items>
                </telerik:RadDropDownList>
            </td>
        </tr>
        <tr>
            <td class="Heading">Remarks</td>
            <td>
                <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="sqlCoatingVendor" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT sc.sub_con_id, sc.sub_con_name
FROM SUB_CONTRACTOR sc
WHERE PAINT_SC = 'Y'
OR EXISTS(SELECT NULL FROM pip_spool ps WHERE ps.mat_type LIKE '%GALV%' AND ps.fab_sc=sc.sub_con_id)
"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlCoatingType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM PIP_COATING_TYPE
ORDER BY COATING_TYPE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlFromVendor" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
</asp:Content>

