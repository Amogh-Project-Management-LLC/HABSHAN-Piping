<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_JobCard_Detail.aspx.cs" Inherits="Supp_JobCard_Detail" Title="Support Job Card" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="80" OnClick="btnView_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server"
                        AutoPostBack="true" EmptyMessage="Search Here" Width="195px" OnTextChanged="txtSearch_TextChanged">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataKeyNames="JC_ID,BOM_ID" DataSourceID="itemstDataSource" Width="100%" AllowPaging="True"
            PageSize="20" OnRowEditing="itemsGridView_RowEditing">
            <MasterTableView DataKeyNames="JC_ID,BOM_ID" AllowAutomaticUpdates="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>                    
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="REV_NO" HeaderText="Rev" SortExpression="REV_NO" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="PT_NO" HeaderText="PT. No" SortExpression="PT_NO" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Support Tag No" SortExpression="MAT_CODE1"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Support Size" SortExpression="SIZE_DESC"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="Description" SortExpression="MAT_DESCR"
                        ReadOnly="True" />
                    
                    <telerik:GridTemplateColumn HeaderText="JC Qty" SortExpression="JC_QTY">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("JC_QTY") %>' Width="50px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("JC_QTY") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="CONSIDER_SHOP_BOM" HeaderText="Consider Shop BOM" SortExpression="CONSIDER_SHOP_BOM" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnUpdateBOM" runat="server" Text="Update Support MTO" Width="140px" OnClick="btnUpdateBOM_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50"
                        OnClick="btnYes_Click" EnableViewState="false" Visible="false" Skin="Sunset">
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50" EnableViewState="false" Visible="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:HiddenField ID="YesNoHiddenField" runat="server" />
    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSupp_BTableAdapters.VIEW_ADP_SUPP_JC_DTTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH_TEXT" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="Original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>
