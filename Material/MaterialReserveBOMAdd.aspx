<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MaterialReserveBOMAdd.aspx.cs" Inherits="Material_MaterialReserveBOMAdd" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
        .Heading {
            width:120px;
            padding-left:5px;
            background-color:whitesmoke;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">Isometric Number:</td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtAutoIsome" runat="server" Width="200px" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_ID" DropDownHeight="300px" 
                        EmptyMessage="Start typing Isometric..." InputType="Text" OnTextChanged="txtAutoIsome_TextChanged" AutoPostBack="true">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">BOM Items:</td>
                <td>
                    <telerik:RadComboBox ID="cboBOMItems" runat="server" Width="450px" CheckBoxes="True" DataSourceID="sqlBOMSource" 
                        DataTextField="BOM_TITLE" DataValueField="BOM_ID" Filter="Contains" EnableCheckAllItemsCheckBox="true"></telerik:RadComboBox>
                </td>
            </tr>
             <tr>
                <td class="Heading">Remarks:</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="450px"></telerik:RadTextBox>
                </td>
            </tr>
             <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="HiddenIsoID" runat="server" />
    <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISO_ID, ISO_TITLE1
FROM VIEW_BOM_SIMPLE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBOMSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_TITLE 
FROM VIEW_BOM_SIMPLE
WHERE ISO_ID = :ISO_ID
ORDER BY PT_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenIsoID" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

