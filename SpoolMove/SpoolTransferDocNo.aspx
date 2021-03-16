<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="SpoolTransferDocNo.aspx.cs" Inherits=" transfdoc_items" Title="Spool Transfer Doc" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= DOCGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <div style="background-color: whitesmoke;">
        <table>
            <tr>

                
                <td>
                    <div id="HeaderDiv">
                        <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False"  />
                    </div>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Visible="false" Text="Save" Width="80px" OnClick="btnSave_Click" />
                </td>


            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; text-align: right; padding: 2px;">
    </div>

    <table runat="server" id="EntryTable" visible="false">

        <tr>
            <td style="width: 180px; background-color: gainsboro">TRANSFER NO

            </td>
            <td style="width: 248px">

                <telerik:RadComboBox ID="RadTRANSNO" runat="server" DataSourceID="TransfDataSource" DataTextField="TRANS_NO" AllowCustomText="true"
                    Filter="Contains" DataValueField="TRANS_ID" Width="250px" Height="200px" AutoPostBack="true" CausesValidation="false">
                </telerik:RadComboBox>
            </td>
        </tr>

        <tr>
            <td style="width: 180px; background-color: gainsboro">DOC REF NO

            </td>

            <td>
                <telerik:RadComboBox ID="RadDocNo" runat="server" DataSourceID="DocDataSource" DataTextField="DOC_REF_NO" AllowCustomText="true"
                    AppendDataBoundItems="true" Filter="Contains" DataValueField="DOC_REF_NO" Width="250px"  Height="200px" AutoPostBack="true" CausesValidation="false">
                </telerik:RadComboBox>
            </td>
        </tr>
    </table>


    <div>
        <telerik:RadGrid ID="DOCGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnItemCommand="DOCGridView_ItemCommand"
            DataKeyNames="UNIQ_ID" DataSourceID="DocViewDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            PageSize="50" AllowSorting="true" PagerStyle-AlwaysVisible="true" >
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <ClientSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView DataSourceID="DocViewDataSource" DataKeyNames="UNIQ_ID" AutoGenerateColumns="False" PageSize="50"
                AllowFilteringByColumn="true" EditMode="InPlace" AllowMultiColumnSorting="true" ClientDataKeyNames="UNIQ_ID" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow" UniqueName="DeleteCommandColumn"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="TRANS_NO" FilterControlAltText="Filter TRANS_NO column" HeaderText="TRANSFER NO"
                        SortExpression="TRANS_NO" UniqueName="TRANS_NO" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="DOC REF NO" SortExpression="DOC_REF_NO" DataField="DOC_REF_NO"
                        AutoPostBackOnFilter="true" UniqueName="DOC_REF_NO" AllowFiltering="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddDOCNO" runat="server" AppendDataBoundItems="True" DataSourceID="DocDataSource"
                                DataTextField="DOC_REF_NO" DataValueField="DOC_REF_NO" SelectedValue='<%# Bind("DOC_REF_NO") %>'
                                Width="180px" DropDownHeight="200px">
                                <Items>
                                    <telerik:DropDownListItem Selected="true" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("DOC_REF_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>


                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>

    </div>

    <asp:SqlDataSource ID="DocViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT UNIQ_ID,PIP_SPL_TRANSFER_DOC.TRANS_ID,PIP_SPL_TRANSFER_DOC.DOC_REF_NO,PIP_SPL_TRANSFER.TRANS_NO
                        FROM PIP_SPL_TRANSFER 
                         INNER JOIN PIP_SPL_TRANSFER_DOC
                         ON PIP_SPL_TRANSFER.TRANS_ID = PIP_SPL_TRANSFER_DOC.TRANS_ID
                     WHERE PIP_SPL_TRANSFER.TRANS_ID =:TRANS_ID"
        DeleteCommand="DELETE FROM PIP_SPL_TRANSFER_DOC  WHERE (UNIQ_ID = :UNIQ_ID)"
        UpdateCommand="UPDATE PIP_SPL_TRANSFER_DOC  
                        SET DOC_REF_NO=:DOC_REF_NO WHERE UNIQ_ID=:UNIQ_ID"
        InsertCommand="INSERT INTO PIP_SPL_TRANSFER_DOC (TRANS_ID,DOC_REF_NO) VALUES (:TRANS_ID,:DOC_REF_NO)">

        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="TRANS_ID" Type="Decimal" />
        </SelectParameters>

        <UpdateParameters>
            <asp:Parameter Name="DOC_REF_NO" Type="String" />
            <asp:Parameter Name="UNIQ_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UNIQ_ID" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter Name="TRANS_ID" ControlID="RadTRANSNO" Type="Decimal" />
            <asp:ControlParameter Name="DOC_REF_NO" ControlID="RadDocNo" Type="String" />
        </InsertParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DocDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT SER_NO AS DOC_REF_NO FROM PIP_SPOOL_TRANS WHERE CAT_ID=8 AND PROJECT_ID = :PROJECT_ID ORDER BY SER_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="TransfDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT TRANS_ID, TRANS_NO   FROM PIP_SPL_TRANSFER WHERE PROJECT_ID = :PROJECT_ID  ORDER BY TRANS_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
