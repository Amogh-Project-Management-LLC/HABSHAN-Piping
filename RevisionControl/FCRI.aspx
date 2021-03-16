<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FCRI.aspx.cs" Inherits="RevisionControl_FCRI" Title="FCRI" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="New" Width="80" OnClick="btnNewTrans_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="Spools" Width="80" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSplList" runat="server" Text="Spools Report" Width="110px" OnClick="btnSplList_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnWeldImpact" runat="server" Text="Weld Impact" Width="100" OnClick="btnWeldImpact_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMatImpact" runat="server" Text="Mat Impact" Width="100" OnClick="btnMatImpact_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server"
                        EmptyMessage="Search.." AutoPostBack="True" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="120px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="relGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="fcriDataSource" PageSize="20" Width="100%" SkinID="GridViewSkin"
            OnRowEditing="scrGridView_RowEditing" OnDataBound="scrGridView_DataBound" DataKeyNames="FCRI_ID">
            <Columns>
                <asp:CommandField ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    SelectImageUrl="~/Images/icon-select.gif" ShowEditButton="True" ShowSelectButton="True"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="FCRI_NO" HeaderText="FCRI No" SortExpression="FCRI_NO">
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="FCRI Date" SortExpression="REL_DATE">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("REL_DATE", "{0:dd-MMM-yyyy}") %>'
                            Width="78px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("REL_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SubconDataSource"
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SUB_CON_ID") %>'
                            Width="130px">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="100px" />
                </asp:TemplateField>
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
        </asp:GridView>
    </div>

    <div style="background-color: gainsboro;">
        <table>
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
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="fcriDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsIsomeControlBTableAdapters.VIEW_FCRITableAdapter"
        UpdateMethod="UpdateQuery" InsertMethod="InsertQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_FCRI_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FCRI_NO" Type="String" />
            <asp:Parameter Name="REL_DATE" Type="DateTime" />
            <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_FCRI_ID" Type="Decimal" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="FCRI_NO" Type="String" />
            <asp:Parameter Name="REL_DATE" Type="DateTime" />
            <asp:Parameter Name="SUB_CON_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FCRI_NO" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>