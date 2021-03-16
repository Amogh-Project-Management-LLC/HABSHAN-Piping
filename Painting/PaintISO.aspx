<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PaintISO.aspx.cs" Inherits="PaintISO_PaintISO" Title="Paint Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: #99ccff">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                                Text="Back" Width="80px" OnClick="btnBack_Click" />
                        </td>
                        <td style="width: 100%" align="right">
                            <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px"
                                AutoPostBack="True"></telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="137px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="LooseIssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="PAINT_ID" DataSourceID="LooseIssueDataSource"
                    PageSize="15" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="LooseIssueGridView_DataBound">
                    <PagerSettings PageButtonCount="15" />
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                            CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                            ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                            <ItemStyle Width="50px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="BLK_PNT_REQ" HeaderText="Paint Req" SortExpression="BLK_PNT_REQ" />
                        <asp:BoundField DataField="REQ_DATE" HeaderText="Req Date" SortExpression="REQ_DATE"
                            DataFormatString="{0:dd-MMM-yyyy}" ApplyFormatInEditMode="true" HtmlEncode="false" />
                        <asp:BoundField DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME"
                            ReadOnly="true" />
                        <asp:BoundField DataField="STORE_L1" HeaderText="Store Name" SortExpression="STORE_L1"
                            ReadOnly="true" />
                        <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                    </Columns>
                    <SelectedRowStyle CssClass="SelectedRowStyle" />
                    <HeaderStyle CssClass="HeaderStyle" />
                    <AlternatingRowStyle CssClass="AlternatingRowStyle" />
                    <PagerStyle ForeColor="DarkBlue" Font-Bold="True" />
                    <EmptyDataTemplate>
                        No Paint Requests!
                    </EmptyDataTemplate>
                    <EmptyDataRowStyle CssClass="EmptyDataStyle" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff;">
                <table>
                    <tr>
                        <td>
                            <asp:Button ID="btnNewIssue" runat="server" Text="Register" Width="84px" BackColor="SkyBlue"
                                BorderColor="SteelBlue" OnClick="btnNewIssue_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnViewMats" runat="server" OnClick="btnViewMats_Click" Text="Materials"
                                Width="81px" BackColor="SkyBlue" BorderColor="SteelBlue" />
                        </td>
                        <td>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" Width="84px" BackColor="SkyBlue"
                                BorderColor="SteelBlue" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <asp:Button ID="btnYes" runat="server" Text="Yes" Width="41px" BackColor="PowderBlue"
                                BorderColor="SteelBlue" OnClick="btnYes_Click" EnableViewState="False" Visible="False" />
                        </td>
                        <td>
                            <asp:Button ID="btnNo" runat="server" Text="No" Width="41px" BackColor="PowderBlue"
                                BorderColor="SteelBlue" EnableViewState="False" Visible="False" />
                        </td>
                        <td style="width: 100%" align="right">
                            <asp:DropDownList ID="ddReports" runat="server" Width="400px">
                                <asp:ListItem Selected="True" Value="1" Text="Paint Request Summary"></asp:ListItem>
                                <asp:ListItem Value="2" Text="Material Request"></asp:ListItem>
                                <asp:ListItem Value="3" Text="Paint Request Details"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnPreview" runat="server" Text="Preview" Width="78px" BackColor="PowderBlue"
                                BorderColor="SteelBlue" EnableViewState="False" OnClick="btnPreview_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="LooseIssueDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsPaintingISOTableAdapters.VIEW_PAINTING_ISOTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="BLK_PNT_REQ" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="BLK_PNT_REQ" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
