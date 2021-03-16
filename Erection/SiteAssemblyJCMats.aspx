<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SiteAssemblyJCMats.aspx.cs" Inherits="SiteAssemblyJCItems"
    Title="Loose Material Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                CausesValidation="false" Text="Entry" Width="80px" OnClick="btnEntry_Click" visible="false"/>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80px" OnClick="btnSubmit_Click" Visible="False" />
                        </td>
                        <td align="right" style="width: 100%">
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
                    CssClass="DataWebControlStyle" DataSourceID="itemsDataSource" Width="100%" OnRowEditing="itemsGridView_RowEditing"
                    OnDataBound="itemsGridView_DataBound" PageSize="15" DataKeyNames="JC_ID,BOM_ID">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="JC_ID,BOM_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>                                                      
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" />
                            <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                            <telerik:GridBoundColumn DataField="PT_NO" HeaderText="Part No" SortExpression="PT_NO" />
                            <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1" />
                            <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" SortExpression="SIZE_DESC" />
                            <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thk" SortExpression="WALL_THK" />
                            <telerik:GridBoundColumn DataField="QTY" HeaderText="Erec Qty" SortExpression="QTY" />
                            <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
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
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsErectionTableAdapters.VIEW_SITE_JC_ASSEMBLY_DETAILTableAdapter">
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
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ISO_ID, BOM_ID, ISO_TITLE1||'_'||MAT_CODE1||'_'||PT_NO AS BOM_ITEM FROM VIEW_SITE_ASSEMBLY_REQUIRED WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 = :ISO_TITLE)">
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
