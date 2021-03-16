<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_MatItems.aspx.cs" Inherits="Erection_Additional_MatItems"
    Title="Additional Material Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table id="EntryTable" runat="server" visible="false">
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
                <td>
                    <telerik:RadSearchBox ID="txtMatSearch" runat="server" DataSourceID="sqlMatSource" DataTextField="MAT_CODE1" DataValueField="MAT_ID" 
                        EmptyMessage="Search Item Code...." OnSearch="txtMatSearch_Search"></telerik:RadSearchBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Heat No"></asp:Label>
                </td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtAutoHeatNo" runat="server" DataSourceID="sqlHeatNoSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO" 
                        EmptyMessage="Heat Number..." InputType="Text">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                    <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtAutoHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadAutoCompleteBox ID="txtAutoPaintSys" runat="server" DataSourceID="sqlPaintSource" DataTextField="PAINT_CODE" DataValueField="PAINT_CODE" 
                        InputType="Text">
                        <TextSettings SelectionMode="Single" />
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label6" runat="server" Text="Issued Qty"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtQty" runat="server" Width="80px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="ADD_ISSUE_ID,MAT_ID,HEAT_NO" DataSourceID="itemsDataSource" OnDataBound="itemsGridView_DataBound" PageSize="20" Width="100%">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView DataKeyNames="ADD_ISSUE_ID,MAT_ID,HEAT_NO" AllowAutomaticUpdates="true">
                <Columns>
                   <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                    
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"
                        ReadOnly="true" />                    
                    <telerik:GridTemplateColumn HeaderText="Heat Numbers" SortExpression="HEAT_NO">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="81px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PAINT_CODE" HeaderText="Paint Code" SortExpression="PAINT_CODE" />
                    <telerik:GridTemplateColumn HeaderText="Issued Qty" SortExpression="ISSUE_QTY">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ISSUE_QTY") %>' Width="57px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("ISSUE_QTY") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
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

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.PIP_MAT_ISSUE_ADD_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="original_HEAT_NO" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
            <asp:Parameter Name="original_HEAT_NO" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ADD_ISSUED_ID" QueryStringField="ADD_ISSUE_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="mrirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_RCV_ID, MAT_RCV_NO FROM PIP_MAT_RECEIVE WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY MAT_RCV_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMatSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1 FROM PIP_MAT_STOCK"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHeatNoSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT HEAT_NO 
FROM PRC_MAT_INSP_DETAIL
WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenMatID" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPaintSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PAINT_CODE
FROM PIP_BOM
WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenMatID" DefaultValue="-1" Name="MAT_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenMatID" runat="server" />
</asp:Content>
