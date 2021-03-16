<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatExceptionRepItems.aspx.cs" Inherits="Material_MatExceptionRepItems"
    Title="ESD" %>

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
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="New" Width="80" CausesValidation="false" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click" Visible="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnImportMRIR" runat="server" Text="Update From MRIR" Width="150px"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table runat="server" id="EntryTable" visible="false">
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <telerik:RadLabel ID="Label6" runat="server" Text="Po Item No"></telerik:RadLabel>
                </td>
                <td style="height: 29px">
                    <telerik:RadTextBox ID="txtPOitem" runat="server" Width="60px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="poItemValidator" runat="server" ControlToValidate="txtPOitem"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Material Code"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMatCode" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="matCodeValidator" runat="server" ControlToValidate="txtMatCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Heat No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtHeatNo" runat="server" Width="108px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="hnValidator" runat="server" ControlToValidate="txtHeatNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="Label3" runat="server" Text="Exception Flag"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboFalg" runat="server" AppendDataBoundItems="True" DataSourceID="flagDataSource"
                        DataTextField="EXCP_DESCR" DataValueField="EXCP_FLG" Width="150px">
                        <Items>
                            <telerik:DropDownListItem Selected="True" Text="(SELECT)" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="flagValidator" runat="server" ControlToValidate="cboFalg"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label4" runat="server" Text="Exception Qty"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="63px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="excpQtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="Label5" runat="server" Text="Remarks"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="EXCP_ITEM_ID" DataSourceID="itemsDataSource" SkinID="GridViewSkin"
            OnDataBound="itemsGridView_DataBound" PageSize="30" Width="100%" AllowAutomaticDeletes="True" MasterTableView-EditMode="InPlace">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="EXCP_ITEM_ID" AllowAutomaticUpdates="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Are you sure to delete?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn HeaderText="PO Item" SortExpression="PO_ITEM">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PO_ITEM") %>' Width="53px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("PO_ITEM") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MatCode1" ReadOnly="True" SortExpression="MAT_CODE1" />
                    <telerik:GridTemplateColumn HeaderText="Heat No" SortExpression="HEAT_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="76px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Excp Flg" SortExpression="EXCP_FLG">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList1" runat="server" DataSourceID="flagDataSource"
                                DataTextField="EXCP_DESCR" DataValueField="EXCP_FLG" SelectedValue='<%# Bind("EXCP_FLG") %>'
                                Width="102px">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("EXCP_FLG") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Excp Qty" SortExpression="EXCP_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("EXCP_QTY") %>' Width="62px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("EXCP_QTY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                    <telerik:GridTemplateColumn HeaderText="Cleared" SortExpression="CLEAR_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("CLEAR_DATE") %>' Width="120px"></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("CLEAR_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Height="17px" Text='<%# Bind("REMARKS") %>'
                                Width="221px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemStyle Font-Size="Smaller" />
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="StockDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1  FROM PIP_MAT_STOCK WHERE PROJ_ID = :PROJECT_ID&#13;&#10;ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="flagDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT EXCP_FLG, EXCP_DESCR FROM PIP_MAT_EXCEPTION_FLG ORDER BY EXCP_DESCR'></asp:SqlDataSource>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPO_ShipmentATableAdapters.PIP_MAT_EXCEPTION_REP_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_EXCP_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="EXCP_FLG" Type="String" />
            <asp:Parameter Name="EXCP_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="CLEAR_DATE" Type="DateTime" />
            <asp:Parameter Name="original_EXCP_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="EXCP_ID" QueryStringField="EXCP_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
