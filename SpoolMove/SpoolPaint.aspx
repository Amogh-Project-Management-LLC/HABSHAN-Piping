<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolPaint.aspx.cs" Inherits="SpoolMove_SpoolPaint" Title="Spool Paint" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <script type="text/javascript">
     window.onresize = Test;
     Sys.Application.add_load(Test);
     function Test() {
         var grid = $find('<%= TransGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth;
            grid.get_element().style.height = (height) - document.getElementById("grad").clientHeight - document.getElementById("MasterHeader").clientHeight
                - document.getElementById("headerButtons").clientHeight - document.getElementById("FooterButtons").clientHeight
                - document.getElementById("MasterFooter").clientHeight - 20 + "px";
            grid.get_element().style.width = width - 25 + "px";
            grid.get_element()
            grid.repaint();
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= TransGridView.ClientID %>").get_masterTableView().editItem(editedRow);
     }
 </script>  
    <div style="background-color: whitesmoke;" id="headerButtons">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="New" Width="80" OnClick="btnNewTrans_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewSpls" runat="server" Text="Spools" Width="80" OnClick="btnViewSpls_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSCR_PDF1" runat="server" Text="SCR PDF" Width="90" OnClick="btnSCR_PDF1_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSCRFrom" runat="server" EmptyMessage="From" Visible="false" Width="80"></telerik:RadTextBox>
                    <telerik:RadTextBox ID="txtSCRTo" runat="server" EmptyMessage="To" Visible="false" Width="80"></telerik:RadTextBox>
                    <telerik:RadButton ID="btnSCR_PDF" runat="server" Text="Create Zip" Width="120"
                        OnClick="btnSCR_PDF_Click" Visible="false">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnBulkImportSpl" runat="server" Text="Bulk Import" Width="120" OnClick="btnBulkImportSpl_Click"></telerik:RadButton>
                </td>
               
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search.." AutoPostBack="True" Width="200px"  Visible="false">
                    </telerik:RadTextBox>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="140px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="TransGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowSorting="true"
            DataKeyNames="SPL_PNT_ID" DataSourceID="TransDataSource" SkinID="GridViewSkin" AllowAutomaticDeletes="true"
            PageSize="12" OnDataBound="TransGridView_DataBound" OnRowEditing="TransGridView_RowEditing"  AllowFilteringByColumn="true"
            OnItemCommand="TransGridView_ItemCommand" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
        <GroupingSettings CollapseAllTooltip="Collapse all groups" />
        <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
            <Selecting AllowRowSelect="True"></Selecting>
            <Scrolling AllowScroll="True" UseStaticHeaders="True"></Scrolling>
            
        </ClientSettings>
        <ClientSettings AllowKeyboardNavigation="true">
            <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
        </ClientSettings>
            <MasterTableView AllowAutomaticUpdates="true" AllowAutomaticDeletes="true" DataKeyNames="SPL_PNT_ID" EditMode="InPlace" AllowMultiColumnSorting="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                     

                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                          <ItemStyle Width="50px" />
                            <HeaderStyle Width="50px" />
                    </telerik:GridEditCommandColumn>
                     <telerik:GridButtonColumn ConfirmText="Delete this Record?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn DataField="PNT_REQ_NO" HeaderText="Paint Req No" SortExpression="PNT_REQ_NO" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PNT_REQ_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("PNT_REQ_NO") %>'></asp:Label>
                        </ItemTemplate>
                          <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="REQ_DATE" HeaderText="Request date" SortExpression="REQ_DATE" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="TextBox2" runat="server" DbSelectedDate='<%# Bind("REQ_DATE", "{0:dd-MMM-yyyy}") %>'
                                 DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("REQ_DATE", "{0:dd-MMM-yyyy}") %>'>
                                </asp:Label>
                        </ItemTemplate>
                          <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="TAR_COMPLETE" HeaderText="Target Cmplt" SortExpression="TAR_COMPLETE" AutoPostBackOnFilter="true"> 
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="TextBox3" runat="server" DbSelectedDate='<%# Bind("TAR_COMPLETE", "{0:dd-MMM-yyyy}") %>'
                                 DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("TAR_COMPLETE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                          <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' ></asp:Label>
                        </ItemTemplate>
                          <ItemStyle Width="150px" />
                            <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox6" runat="server" Font-Underline="False" Text='<%# Bind("REMARKS") %>'
                                Width="209px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Font-Underline="False" Text='<%# Bind("REMARKS") %>'
                                Width="209px"></asp:Label>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                            <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <div style="background-color: whitesmoke" id="FooterButtons">
        <table style="width: 100%">
            <tr>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadDropDownList ID="ddReports" runat="server" Width="250px">
                        <Items>
                            <telerik:DropDownListItem Value="2" Text="Spool List for Painting" Selected="true" />
                            <telerik:DropDownListItem Value="2.3" Text="Material Summary" />
                            <%-- <telerik:DropDownListItem Value="2.1" Text="Primer and Intermediate" />
                            <telerik:DropDownListItem Value="2.2" Text="Finish" />--%>
                            
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
        TypeName="dsSpoolMoveTableAdapters.PIP_PAINTING_SPLTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="PNT_REQ_NO" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="TAR_COMPLETE" Type="DateTime" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="RAL_NO" Type="String" />
            <asp:Parameter Name="FINISH_COLOR" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_SPL_PNT_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_PNT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="PNT_REQ_NO" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "SUB_CON_ID", "SUB_CON_NAME" FROM "SUB_CONTRACTOR" ORDER BY "SUB_CON_NAME"'></asp:SqlDataSource>
</asp:Content>
