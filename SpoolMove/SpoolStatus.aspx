<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolStatus.aspx.cs" Inherits="SpoolControl_SpoolStatus" Title="Spool Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[

            function SpoolStatus() {
                try {
                    var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("SPL_ID");
                    radopen("SpoolStatusFab.aspx?SPL_ID=" + id, "RadWindow2", 650, 600);
                }
                catch (err) {
                    txt = "Select any spool!";
                    alert(txt);
                }
            }

            function SpoolPainting() {
                try {
                    var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("SPL_ID");
                    radopen("SpoolStatusPaint.aspx?SPL_ID=" + id, "RadWindow2", 650, 450);
                }
                catch (err) {
                    txt = "Select any spool!";
                    alert(txt);
                }
            }

            window.onresize = Test;
            Sys.Application.add_load(Test);
           function Test() {
                var grid = $find('<%= RadGrid1.ClientID %>')
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

                var masterTable = $find("<%=RadGrid1.ClientID %>").get_masterTableView();
                grid.get_element().style.height = (height) - 200 + "px";
                grid.get_element().style.width = width - 20 + "px";
                grid.get_element()
                grid.repaint();
            }
        </script>

    </telerik:RadCodeBlock>
    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td>
                    <div id ="btFooter">
                    <asp:LinkButton ID="linkPDF" runat="server" OnClientClick="SpoolStatus(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton ID="btnFabStatus" runat="server" Text="Spool Status" Width="100"></telerik:RadButton>
                    </asp:LinkButton>
                        </div>
                </td>
                <td>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="SpoolPainting(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton ID="btnPaintStatus" runat="server" Text="Painting" Width="100"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search Isometric" Width="300px" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" Visible="false">
                            </telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="RadGrid1_DataSource"
                    CellSpacing="-1" OnItemDataBound="itemsGrid_ItemDataBound" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="true" />
                        <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
                    </ClientSettings>
                    <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataSourceID="RadGrid1_DataSource" AllowPaging="true"
                        HierarchyLoadMode="Client" PageSize="50" EditMode="PopUp" EditFormSettings-PopUpSettings-Modal="true" DataKeyNames="SPL_ID" ClientDataKeyNames="SPL_ID">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridTemplateColumn ItemStyle-Width="15px" AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="30px" />
                                <HeaderStyle Width="30px" />

                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="Isometric No" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                <ItemStyle Width="130px" />
                                <HeaderStyle Width="130px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="SHEET" FilterControlAltText="Filter SHEET column" HeaderText="Sheet" SortExpression="SHEET" UniqueName="SHEET" AllowFiltering="false">
                                <ItemStyle Width="60px" />
                                <HeaderStyle Width="60px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="Spool" SortExpression="SPOOL" UniqueName="SPOOL" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JC_NO" FilterControlAltText="Filter JC_NO column" HeaderText="Jobcard No" SortExpression="JC_NO" UniqueName="JC_NO" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MAT_AVL" FilterControlAltText="Filter MAT_AVL column" HeaderText="Material Avl." SortExpression="MAT_AVL" UniqueName="MAT_AVL" AutoPostBackOnFilter="true" FilterControlWidth="15px">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WELD_DATE" FilterControlAltText="Filter WELD_DATE column" HeaderText="Weld Date" SortExpression="WELD_DATE" UniqueName="WELD_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SHOP_ID" DataType="System.Decimal" FilterControlAltText="Filter SHOP_ID column" HeaderText="Shop ID" SortExpression="SHOP_ID" UniqueName="SHOP_ID" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SFR" FilterControlAltText="Filter SFR column" HeaderText="SFR" SortExpression="SFR" UniqueName="SFR" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NDE_CMPLT" DataType="System.DateTime" FilterControlAltText="Filter NDE_CMPLT column" HeaderText="NDT Complete" SortExpression="NDE_CMPLT" UniqueName="NDE_CMPLT" DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAINT_CLR" DataType="System.DateTime" FilterControlAltText="Filter PAINT_CLR column" HeaderText="Paint Clear" SortExpression="PAINT_CLR" UniqueName="PAINT_CLR" DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PAINT_REP" FilterControlAltText="Filter PAINT_REP column" HeaderText="Paint Report No" SortExpression="PAINT_REP" UniqueName="PAINT_REP" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="INT_BLST_REP" FilterControlAltText="Filter INT_BLST_REP column" HeaderText="Int Blast Report" SortExpression="INT_BLST_REP" UniqueName="INT_BLST_REP" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="INT_BLST_DATE" FilterControlAltText="Filter INT_BLST_DATE column" HeaderText="Int Blast Date" SortExpression="INT_BLST_DATE" UniqueName="INT_BLST_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EXT_BLST_REP" FilterControlAltText="Filter EXT_BLST_REP column" HeaderText="Ext Blast Rep" SortExpression="EXT_BLST_REP" UniqueName="EXT_BLST_REP" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EXT_BLST_DATE" FilterControlAltText="Filter EXT_BLST_DATE column" HeaderText="Ext Blast Date" SortExpression="EXT_BLST_DATE" UniqueName="EXT_BLST_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CLEAR_DATE" DataType="System.DateTime" FilterControlAltText="Filter CLEAR_DATE column" HeaderText="Clear Date" SortExpression="CLEAR_DATE" UniqueName="CLEAR_DATE" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SITE_EREC" DataType="System.DateTime" FilterControlAltText="Filter SITE_EREC column" HeaderText="Erection Date" SortExpression="SITE_EREC" UniqueName="SITE_EREC" DataFormatString="{0:dd-MMM-yyyy}" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:ObjectDataSource ID="RadGrid1_DataSource" runat="server" SelectMethod="GetData"
        TypeName="dsSpoolMoveTableAdapters.VIEW_SPOOL_STATUSTableAdapter" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="ISO_TITLE1" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
