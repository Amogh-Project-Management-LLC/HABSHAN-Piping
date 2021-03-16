<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="SpoolTrans.aspx.cs" Inherits="SpoolMove_SpoolTrans" Title="Spool Transmittal" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= TransGridView.ClientID %>')
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

                var masterTable = $find("<%=TransGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }

    </script>
    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="Register" Width="80" ></telerik:RadButton>
                    <telerik:RadButton ID="btnViewSpools" runat="server" Text="Spools" Width="80" OnClick="btnViewSpools_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="110" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" OnClick="btnBulkImport_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnSplHistory" runat="server" Text="Spool History Sheet" OnClick="btnSplHistory_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnSFRHistory" runat="server" Text="SFR History Sheet" OnClick="btnSFRHistory_Click"></telerik:RadButton>
                    <telerik:RadLabel ID="lblWarning" runat="server" Text=""></telerik:RadLabel>

                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" Visible="false"
                        EmptyMessage="Search.." AutoPostBack="True" Width="200px">
                    </telerik:RadTextBox>
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="140px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="TransGridView" runat="server" CellSpacing="-1" DataSourceID="splTransDataSource"
            AllowPaging="True" PageSize="50" OnDataBound="TransGridView_DataBound" MasterTableView-AllowPaging="true" Width="100%" OnItemCommand="TransGridView_ItemCommand"
            OnItemDataBound="itemsGrid_ItemDataBound" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="splTransDataSource" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
                DataKeyNames="TRANS_ID" EditMode="PopUp">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridTemplateColumn ItemStyle-Width="15px" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this Spool?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                        <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="SER_NO" FilterControlAltText="Filter SER_NO column" HeaderText="SERIAL NUMBER" FilterControlWidth="150px" AutoPostBackOnFilter="true"
                        SortExpression="SER_NO" UniqueName="SER_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="ISSUED BY" FilterControlWidth="100px" AutoPostBackOnFilter="true"
                        SortExpression="USER_NAME" UniqueName="USER_NAME" ReadOnly="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn  DataField="ISSUE_DATE" DataType="System.DateTime" HeaderText="ISSUE DATE" 
                        SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE"  AutoPostBackOnFilter="true" FilterControlWidth="100px">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtIssueDateEdit" runat="server" SelectedDate='<%# Bind("ISSUE_DATE") %>' 
                                DateInput-DateFormat="dd-MMM-yyyy" >
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblIssueDate" runat="server" Text='<%# Eval("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>' ></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="SUBCON" SortExpression="SUB_CON_NAME"  DataField="SUB_CON_NAME"  FilterControlWidth="120px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddSubCon" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>' >
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>

                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSubCon" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' ></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>


                    <telerik:GridBoundColumn DataField="SPLS_COUNT" FilterControlAltText="Filter SPLS_COUNT column" HeaderText="SPOOLS" ReadOnly="true" AllowFiltering="false"
                        SortExpression="SPLS_COUNT" UniqueName="SPLS_COUNT">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" AllowFiltering="false"
                        SortExpression="REMARKS" UniqueName="REMARKS">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="splTransDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsSpoolMoveTableAdapters.VIEW_ADAPTER_SPL_TRANSTableAdapter"
        UpdateMethod="UpdateQueryIRN" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_TRANS_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="SER_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_TRANS_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="CAT_ID" QueryStringField="CAT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
