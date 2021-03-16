<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="BomRequest.aspx.cs" Inherits="PipeSupport_BomRequest" Title="Material Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: #99ccff">
                <table style="width: 100%">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnPreview" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="Preview" Width="80px" OnClick="btnPreview_Click1" />
                        </td>
                        <td>
                            <asp:Button ID="btnRegist" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="Register" Width="80px" OnClick="btnRegist_Click" />
                        </td>
                        <td align="right" style="width: 100%">
                            <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                                EmptyMessage="Search Here" Width="195px" BackColor="#FFFF66" Style="background-color: #FFFFCC"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="rowsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CssClass="DataWebControlStyle" DataSourceID="rowsDataSource" Width="100%" DataKeyNames="REQ_ID"
                            PageSize="15" OnRowEditing="rowsGridView_RowEditing">
                            <Columns>
                                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                                    ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                                    <ItemStyle Width="50px" />
                                </asp:CommandField>
                                <asp:BoundField DataField="BOM_REQ_NO" HeaderText="Request No" SortExpression="BOM_REQ_NO" />
                                <asp:BoundField DataField="REQ_DATE" HeaderText="Receive Date" SortExpression="REQ_DATE"
                                    DataFormatString="{0:dd-MMM-yyyy}" ApplyFormatInEditMode="true" HtmlEncode="false" />
                                <asp:BoundField DataField="AREA_L1" HeaderText="Area" SortExpression="AREA_L1" />
                                <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME"
                                    ReadOnly="true" />
                                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Columns>
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                            <PagerSettings PageButtonCount="15" />
                            <EmptyDataTemplate>
                                No Information!
                            </EmptyDataTemplate>
                            <PagerStyle Font-Bold="True" Font-Italic="False" ForeColor="DarkGreen" />
                            <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="txtSearch" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff;">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnView" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="BOM Items" Width="100px" OnClick="btnView_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                Text="Delete" Width="80px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnYes" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="Yes" Visible="False" Width="44px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnNo" runat="server" BackColor="PowderBlue" BorderColor="SteelBlue"
                                EnableViewState="False" Text="No" Visible="False" Width="44px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="rowsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionATableAdapters.VIEW_BOM_REQUESTTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="BOM_REQ_NO" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="AREA_L1" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="BOM_REQ_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>