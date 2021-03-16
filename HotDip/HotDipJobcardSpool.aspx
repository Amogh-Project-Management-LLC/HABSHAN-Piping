<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="HotDipJobcardSpool.aspx.cs" Inherits="HotDip_HotDipJobcardSpool" Title="Hot Dip" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntryMode" runat="server" Text="New" Width="80" OnClick="btnEntryMode_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="JC_ID,SPL_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
            PageSize="20" Width="100%" OnDataBound="itemsGridView_DataBound">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                    ReadOnly="true" />
                <asp:BoundField DataField="SHEET" HeaderText="Sheet No" SortExpression="SHEET" ReadOnly="true" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="true" />
                <asp:BoundField DataField="MAT_TYPE" HeaderText="Mat Type" SortExpression="MAT_TYPE"
                    ReadOnly="true" />
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
            <EmptyDataTemplate>
                No Information!
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" Visible="False" Width="200px" EmptyMessage="Isometric No">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="350px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Save" Width="80" OnClick="btnAddSpool_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsHotDipTableAdapters.VIEW_HOT_DIP_JOBCARD_SPLTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_SPL_INDEX WHERE (PROJ_ID = :PROJ_ID) AND (ISO_TITLE1 = :ISO) AND (SPOOL LIKE FNC_FILTER('SPL-')) AND (HOT_DIP_NEED = 'Y') ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>