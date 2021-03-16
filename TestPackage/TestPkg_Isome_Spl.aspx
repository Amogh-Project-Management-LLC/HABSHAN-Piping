<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TestPkg_Isome_Spl.aspx.cs" Inherits="TestPkg_Isome_Spl" Title="Test Package Spools" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= spoolsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" OnClick="btnBack_Click" Text="Back" Width="90px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEntryMode" runat="server" OnClick="btnEntryMode_Click" Text="Entry" Width="90px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <telerik:RadGrid ID="spoolsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="True" PagerStyle-AlwaysVisible="true"
                    CssClass="DataWebControlStyle" DataKeyNames="TPK_ITEM_ID,SPL_ID" DataSourceID="itemsDataSource"
                    Width="820px" PageSize="15">
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="TPK_ITEM_ID,SPL_ID" AllowAutomaticUpdates="true">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="30px" />
                                <HeaderStyle Width="30px" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridBoundColumn DataField="SPL_TITLE" HeaderText="Spool Title" SortExpression="SPL_TITLE" ReadOnly="true" AutoPostBackOnFilter="true" AllowFiltering="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete" Width="90px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="41px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="41px" />
                        </td>
                        <td align="right" style="width: 100%">
                            <asp:DropDownList ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                                DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="324px">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnAddSpool" runat="server" OnClick="btnAddSpool_Click" Text="Add Spool" Visible="False" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsTestPkg_BTableAdapters.TPK_ISOME_SPLTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TPK_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <%--<asp:Parameter Name="SPL_ID" Type="Decimal" />--%>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TPK_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TPK_ITEM_ID" QueryStringField="TPK_ITEM_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_SPOOL_TITLE WHERE (NOT (SPL_ID IN (SELECT SPL_ID FROM TPK_ISOME_SPL))) AND (ISO_ID = :ISO_ID) ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="ISO_ID" QueryStringField="ISO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
