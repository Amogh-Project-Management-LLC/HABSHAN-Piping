<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="SpoolTransSpools.aspx.cs" Inherits="SpoolMove_SpoolTransSpools" Title="Spool Transmittal" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                    <telerik:RadButton ID="btnEntryMode" runat="server" Text="Entry" Width="80" OnClick="btnEntryMode_Click" CausesValidation="false"></telerik:RadButton>
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" Visible="False"
                        Width="250px" EmptyMessage="Isometric No" OnTextChanged="txtIsome_TextChanged">
                    </telerik:RadTextBox>
                    <telerik:RadDropDownList ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="350px">
                    </telerik:RadDropDownList>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Save" Width="80" OnClick="btnAddSpool_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="text-align:right">
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowFilteringByColumn="true" OnItemCommand="itemsGridView_ItemCommand"
            AllowPaging="True" PageSize="30" OnDataBound="itemsGridView_DataBound" MasterTableView-AllowPaging="true" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" CaseSensitive="false"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
                DataKeyNames="SPL_ID,CAT_ID" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this Spool?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="AREA_L2" FilterControlAltText="Filter AREA_L2 column" HeaderText="AREA" SortExpression="AREA_L2" UniqueName="AREA_L2" ReadOnly="true" ItemStyle-Width="100px" AllowFiltering="true" AutoPostBackOnFilter="true"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_TITLE" FilterControlAltText="Filter SPL_TITLE column" HeaderText="Spool Title" SortExpression="SPL_TITLE" UniqueName="SPL_TITLE" ReadOnly="true" ItemStyle-Width="200px" AllowFiltering="true" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn HeaderText="Revision" SortExpression="SPL_REV" ReadOnly="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSplRev" runat="server" Text='<%# Bind("SPL_REV") %>' Width="30px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Width="50px" />
                        <ItemTemplate>
                            <asp:Label ID="lblSplRev" runat="server" Text='<%# Bind("SPL_REV") %>' Width="15px"></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="SPL_LEN" DataFormatString="{0:f}" FilterControlAltText="Filter SPL_LEN column" HeaderText="Length" SortExpression="SPL_LEN" UniqueName="SPL_LEN" ReadOnly="true" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_TYPE" FilterControlAltText="Filter MAT_TYPE column" HeaderText="Material Type" SortExpression="MAT_TYPE" UniqueName="MAT_TYPE" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FITUP_DATE" FilterControlAltText="Filter FITUP_DATE column" HeaderText="FITUP DATE" SortExpression="FITUP_DATE" UniqueName="FITUP_DATE"  DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}"  ReadOnly="true" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_DATE" FilterControlAltText="Filter WELD_DATE column" HeaderText="WELD DATE" SortExpression="WELD_DATE" UniqueName="WELD_DATE"  DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}"  ReadOnly="true" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NDE_CMPLT" FilterControlAltText="Filter NDE_CMPLT column" HeaderText="NDE DATE" SortExpression="NDE_CMPLT" UniqueName="NDE_CMPLT"  DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}"  ReadOnly="true" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSpoolMoveTableAdapters.VIEW_ADAPTER_SPL_TRANS_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="Original_CAT_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="Original_CAT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="TRANS_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE
                                                                                                FROM VIEW_SPOOL_WITH_STATUS
                                                                                                WHERE PROJ_ID = :PROJECT_ID
                                                                                                      AND (SPL_ID NOT IN (SELECT SPL_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE CAT_ID = :CAT_ID))
                                                                                                      AND ISO_TITLE1 = :ISO_TITLE1
                                                                                                      AND SPOOL != 'EREC'
                                                                                                      AND HOLD_STATUS = 'N'
                                                                                                      AND (NDE_BALANCE = 'N' OR SITE_FAB_SPL = 'Y' OR SFR = 'Y' OR NVL(SHOP_ID, 0)=0)
                                                                                                      ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="CAT_ID" QueryStringField="CAT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="scIdField" runat="server" />
</asp:Content>
