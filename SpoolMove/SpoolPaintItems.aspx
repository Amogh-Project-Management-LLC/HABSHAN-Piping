<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolPaintItems.aspx.cs" Inherits="SpoolMove_SpoolPaintItems" Title="Spool Painting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= ItemsGridView.ClientID %>')
               var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
               var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

               var masterTable = $find("<%=ItemsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>

    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnJCList_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntryMode" runat="server" Text="Add Spool" Width="120" OnClick="btnEntryMode_Click" CausesValidation="false" Visible="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search.." AutoPostBack="True" Width="200px" Visible="false">
                    </telerik:RadTextBox>
                </td>
                <td style="width: 100%; text-align: right">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="ItemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="SPL_PNT_ID,SPL_ID" DataSourceID="ItemsDataSource" SkinID="GridViewSkin" AllowAutomaticDeletes="true"
            PageSize="20" Width="110%" OnDataBound="ItemsGridView_DataBound" OnRowEditing="ItemsGridView_RowEditing" OnItemCommand="ItemsGridView_ItemCommand"
            PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <MasterTableView AllowAutomaticUpdates="true" EditMode="InPlace" AutoGenerateColumns="False" PageSize="50"
                DataSourceID="ItemsDataSource" DataKeyNames="SPL_PNT_ID,SPL_ID">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
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
                    <telerik:GridBoundColumn DataField="WORK_ORD" HeaderText="JOB CARD" SortExpression="WORK_ORD" AutoPostBackOnFilter="true" FilterControlWidth="30px"
                        ReadOnly="True">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_TITLE" HeaderText="SPOOL TITLE" SortExpression="SPL_TITLE" AutoPostBackOnFilter="true" FilterControlWidth="30px"
                        ReadOnly="True">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_TYPE" HeaderText="MATERIAL" SortExpression="MAT_TYPE" AutoPostBackOnFilter="true" FilterControlWidth="30px"
                        ReadOnly="True">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PS" HeaderText="PS" SortExpression="PS" ReadOnly="True" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SURFACE" HeaderText="SURF-M2" SortExpression="SPL_SURFACE" AutoPostBackOnFilter="true" FilterControlWidth="30px"
                        ReadOnly="True">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="FST_COAT_DT" DataType="System.DateTime" FilterControlAltText="Filter FST_COAT_DT column" HeaderText="FIRST COAT DATE" SortExpression="FST_COAT_DT" UniqueName="FST_COAT_DT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtFstCoatDate" runat="server" DbSelectedDate='<%# Bind("FST_COAT_DT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="FstCoatLabel" runat="server" Text='<%# Eval("FST_COAT_DT", "{0:dd-MMM-yyyy}") %>' Width="100px"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="FIRST COAT REPORT" SortExpression="FST_COAT_REP" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="FSTTextBox6" runat="server" Text='<%# Bind("FST_COAT_REP") %>' Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="FSTLabel2" runat="server" Text='<%# Bind("FST_COAT_REP") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>


                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="SND_COAT_DT" DataType="System.DateTime" FilterControlAltText="Filter SND_COAT_DT column" HeaderText="SECOND COAT DATE" SortExpression="SND_COAT_DT" UniqueName="SND_COAT_DT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtSndCoatDate" runat="server" DbSelectedDate='<%# Bind("SND_COAT_DT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SndCoatLabel" runat="server" Text='<%# Eval("SND_COAT_DT", "{0:dd-MMM-yyyy}") %>' Width="100px"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="SECOND COAT REPORT" SortExpression="SND_COAT_REP" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="SNDTextBox6" runat="server" Text='<%# Bind("SND_COAT_REP") %>' Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SNDLabel2" runat="server" Text='<%# Bind("SND_COAT_REP") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="TRD_COAT_DT" DataType="System.DateTime" FilterControlAltText="Filter TRD_COAT_DT column" HeaderText="THIRD COAT DATE" SortExpression="TRD_COAT_DT" UniqueName="TRD_COAT_DT">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtTrdCoatDate" runat="server" DbSelectedDate='<%# Bind("TRD_COAT_DT") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TrdCoatLabel" runat="server" Text='<%# Eval("TRD_COAT_DT", "{0:dd-MMM-yyyy}") %>' Width="100px"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="THIRD COAT REPORT" SortExpression="TRD_COAT_REP" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="TRDTextBox6" runat="server" Text='<%# Bind("TRD_COAT_REP") %>' Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TRDLabel2" runat="server" Text='<%# Bind("TRD_COAT_REP") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn AllowFiltering="False" DataField="EXT_BLST_DATE" DataType="System.DateTime" FilterControlAltText="Filter EXT_BLST_DATE column" HeaderText="BLASTING DATE" SortExpression="EXT_BLST_DATE" UniqueName="EXT_BLST_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtBlastDate" runat="server" DbSelectedDate='<%# Bind("EXT_BLST_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="blastlbl" runat="server" Text='<%# Eval("EXT_BLST_DATE", "{0:dd-MMM-yyyy}") %>' Width="100px"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="BLASTING REPORT" SortExpression="EXT_BLST_REP" AllowFiltering="false" >
                        <EditItemTemplate>
                            <asp:TextBox ID="BLSTtxt" runat="server" Text='<%# Bind("EXT_BLST_REP") %>' Width="100%"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="BLSTLabel" runat="server" Text='<%# Bind("EXT_BLST_REP") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridTemplateColumn>




                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadSearchBox EmptyMessage="Isometric No" ID="txtIsome" runat="server" AutoPostBack="True"
                        Visible="False" Width="200px" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_TITLE1"
                        OnSearch="txtIsome_Search">
                    </telerik:RadSearchBox>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="300px" CheckBoxes="True"
                        EnableCheckAllItemsCheckBox="true">
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Save" Width="80" OnClick="btnAddSpool_Click" Visible="False"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:TextBox ID="txtIsoId" runat="server" Text='<%# Eval("ISO_ID") %>' Visible="False"
        Width="29px" ReadOnly="True"></asp:TextBox>

    <asp:ObjectDataSource ID="ItemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSpoolMoveTableAdapters.PIP_PAINTING_SPL_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_PNT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="SPL_PNT_ID" QueryStringField="SPL_PNT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SPL_TITLE" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="FST_COAT_REP" Type="String" />
            <asp:Parameter Name="FST_COAT_DT" Type="DateTime" />
             <asp:Parameter Name="SND_COAT_REP" Type="String" />
            <asp:Parameter Name="SND_COAT_DT" Type="DateTime" />
            <asp:Parameter Name="TRD_COAT_REP" Type="String" />
            <asp:Parameter Name="TRD_COAT_DT" Type="DateTime" />
            <asp:Parameter Name="EXT_BLST_REP" Type="String" />
            <asp:Parameter Name="EXT_BLST_DATE" Type="DateTime" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_PNT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SplTitleDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "SPL_ID", "SPL_TITLE" FROM "VIEW_TOTAL_SPOOL_LIST" WHERE (("ISO_ID" = :ISO_ID) AND ("SPOOL" <> :SPOOL)) ORDER BY "SPL_TITLE"'>
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsoId" DefaultValue="0" Name="ISO_ID" PropertyName="Text"
                Type="Decimal" />
            <asp:Parameter DefaultValue="EREC" Name="SPOOL" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISO_TITLE1 FROM VIEW_ADAPTER_SPOOL WHERE FAB_SC = :FAB_SC">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenSC" DefaultValue="-1" Name="FAB_SC" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_TOTAL_SPOOL_LIST SPL
WHERE (SPL.PROJECT_ID = :PROJECT_ID)
AND (SPL.ISO_ID = :ISO_ID) AND SPL.SUB_CON_ID = :SUB_CON_ID
AND (SPL.SPOOL &lt;&gt; 'EREC')
AND NOT EXISTS(SELECT NULL FROM PIP_PAINTING_SPL_DETAIL PD WHERE PD.SPL_ID=SPL.SPL_ID)
AND SPL.NDE_CMPLT IS NOT NULL        
AND ((SPL.SPL_SWN_NO IS NULL) OR (SPL.SPL_SWN_NO IS NOT NULL AND SPL.SPL_REL_NO IS NOT NULL))
AND ((SPL.HOLD_DATE IS NULL) OR (SPL.HOLD_DATE IS NOT NULL AND SPL.REL_DATE IS NOT NULL))
ORDER BY SPL.SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="HiddenIsoID" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenSC" DefaultValue="-1" Name="SUB_CON_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenSC" runat="server" />
    <asp:HiddenField ID="HiddenIsoID" runat="server" />

</asp:Content>
