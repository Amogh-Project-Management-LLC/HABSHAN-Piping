<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatIssueLooseItems.aspx.cs" Inherits="Erection_MatIssueLooseItems"
    Title="Site JC Materials" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
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
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server"
                                CausesValidation="false" OnClick="btnBack_Click" Text="Back" Width="80px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEntry" runat="server"
                                CausesValidation="false" Text="Entry" Width="80px" OnClick="btnEntry_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80px" OnClick="btnSubmit_Click" Visible="False" />
                        </td>
                        <td style="width: 100%;text-align:right">
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="137px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" runat="server" visible="false" id="EntryTable">                                      
                    <tr>
                        <td class="TableStyle" style="width: 110px; background-color: whitesmoke;">
                            <asp:Label ID="Label1" runat="server" Text="Isometric"></asp:Label>
                        </td>
                        <td class="TableStyle">
                            <asp:TextBox ID="txtIsome" runat="server" AutoPostBack="True" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="isomeValidator" runat="server" ControlToValidate="txtIsome"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>                                     
                    <tr>
                        <td class="TableStyle" style="width: 110px; background-color: whitesmoke;">
                            <asp:Label ID="Label2" runat="server" Text="Erection Item"></asp:Label>
                        </td>
                        <td class="TableStyle">
                            <telerik:RadComboBox  ID="cboBOM" runat="server"  DataSourceID="bomDataSource"
                                DataTextField="BOM_ITEM" DataValueField="BOM_ID" Width="332px" AutoPostBack="True"
                                OnSelectedIndexChanged="cboMM_SELECTedIndexChanged" OnDataBinding="cboBOM_DataBinding"
                                EmptyMessage="(Select BOM)" EnableCheckAllItemsCheckBox="true" CheckBoxes="true">                                
                            </telerik:RadComboBox>
                            <asp:CompareValidator ID="itemValidator" runat="server" ControlToValidate="cboBOM"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>                    
                    <tr>
                        <td class="TableStyle" style="width: 110px; background-color: whitesmoke">
                            <asp:Label ID="Label4" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td class="TableStyle">
                            <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataSourceID="itemsDataSource" Width="100%" OnRowEditing="itemsGridView_RowEditing"  AllowFilteringByColumn="True" PagerStyle-AlwaysVisible="true"
                    OnDataBound="itemsGridView_DataBound" PageSize="50" DataKeyNames="JC_ID,BOM_ID">
                     <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" FrozenColumnsCount="3"></Scrolling>
                    </ClientSettings>
                    <MasterTableView DataKeyNames="JC_ID,BOM_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                         <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>                                                      
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" AutoPostBackOnFilter="true" AllowFiltering="true">
                               <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <ItemStyle Width="50px" />
                                <HeaderStyle Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PT_NO" HeaderText="Part No" SortExpression="PT_NO" AutoPostBackOnFilter="true" AllowFiltering="false">
                               <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" AutoPostBackOnFilter="true" AllowFiltering="true">
                               <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" AutoPostBackOnFilter="true" AllowFiltering="false">
                               <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" AutoPostBackOnFilter="true" AllowFiltering="false">
                                 <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="QTY" HeaderText="Erec Qty" SortExpression="QTY" AutoPostBackOnFilter="true" AllowFiltering="false">
                                <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" AutoPostBackOnFilter="true" AllowFiltering="false">
                                 <ItemStyle Width="80px" />
                                <HeaderStyle Width="80px" />
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
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="76px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" OnClick="btnYes_Click" Text="Yes" Visible="False" Width="41px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False" Width="41px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionTableAdapters.VIEW_SITE_JC_DETAILTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_BOM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, BOM_ID, BOM_ITEM, SF FROM VIEW_BOM_EREC_ITEM WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE) AND (SF = 2) ORDER BY BOM_ITEM">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SheetNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SHEET FROM VIEW_SPL_INDEX WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE1) ORDER BY SHEET">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
