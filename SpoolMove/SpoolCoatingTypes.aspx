<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingTypes.aspx.cs" Inherits="SpoolMove_SpoolCoatingTypes" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding-left:5px">
        <telerik:RadButton runat="server" ID="btnAdd" Text="Add" Width="80px" OnClick="btnAdd_Click"></telerik:RadButton>
    </div>
    <div style="margin-top:3px; padding-left:0px">
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="background-color:whitesmoke; padding-left:3px; width:100px; padding-left:5px">Coating Type:</td>
                <td>
                    <telerik:RadTextBox ID="txtCoatingType" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:3px; padding-left:5px">
        <telerik:RadGrid ID="gridItems" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" Width="350px"
             AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="COATING_TYPE" DataSourceID="itemsDataSource" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="20px">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ItemStyle-Width="20px"
                         ConfirmTextFormatString="Are you sure you want to delete {0} ?" DataTextField="COATING_TYPE" ConfirmDialogType="RadWindow"></telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="COATING_TYPE" FilterControlAltText="Filter COATING_TYPE column" HeaderText="COATING_TYPE" ReadOnly="False" SortExpression="COATING_TYPE" UniqueName="COATING_TYPE">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGalvJobcardTableAdapters.PIP_COATING_TYPETableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_COATING_TYPE" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="COATING_TYPE" Type="String" />
            <asp:Parameter Name="Original_COATING_TYPE" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

