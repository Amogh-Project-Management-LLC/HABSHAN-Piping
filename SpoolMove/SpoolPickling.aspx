<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolPickling.aspx.cs" Inherits="SpoolMove_SpoolPaint" Title="Spool Paint" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="New" Width="80" OnClick="btnNewTrans_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewSpls" runat="server" Text="Spools" Width="80" OnClick="btnViewSpls_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRepImport" runat="server" Text="Bulk Report Import.." OnClick="btnRepImport_Click" Width="170px"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search.." AutoPostBack="True" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="TransGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="SPL_PNT_ID" DataSourceID="TransDataSource" PageSize="20" OnDataBound="TransGridView_DataBound" OnRowEditing="TransGridView_RowEditing" Width="100%">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView AllowAutomaticUpdates="true" AllowAutomaticDeletes="true" DataKeyNames="SPL_PICKLING_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20" />
                    </telerik:GridEditCommandColumn>                    
                    <telerik:GridTemplateColumn HeaderText="Pickling Req No" SortExpression="PICKLING_REQ_NO">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PICKLING_REQ_NO") %>'></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("PICKLING_REQ_NO") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Request date" SortExpression="PICKLING_REQ_DATE">
                        <edititemtemplate>
                        <telerik:RadDatePicker ID="TextBox2" runat="server" DbSelectedDate='<%# Bind("PICKLING_REQ_DATE", "{0:dd-MMM-yyyy}") %>'
                            Width="120px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("PICKLING_REQ_DATE", "{0:dd-MMM-yyyy}") %>'
                            Width="94px"></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                  
                    <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                            Width="126px">
                            <asp:ListItem Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' Width="126px"></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Font-Underline="False" Text='<%# Bind("REMARKS") %>'
                            Width="209px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label6" runat="server" Font-Underline="False" Text='<%# Bind("REMARKS") %>'
                            Width="209px"></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: whitesmoke">
        <table style="width: 100%">
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

                    <telerik:RadDropDownList ID="ddReports" runat="server" Width="250px">
                        <Items>
                            <telerik:DropDownListItem Value="54" Text="Spool List for Pickling" Selected="true" />
                          
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="TransDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsSpoolMoveTableAdapters.VIEW_ADAPTER_PKLNG_SPLTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="PICKLING_REQ_NO" Type="String" />
            <asp:Parameter Name="PICKLING_REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_SPL_PICKLING_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_PICKLING_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="PICKLING_REQ_NO" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "SUB_CON_ID", "SUB_CON_NAME" FROM "SUB_CONTRACTOR" ORDER BY "SUB_CON_NAME"'></asp:SqlDataSource>
</asp:Content>
