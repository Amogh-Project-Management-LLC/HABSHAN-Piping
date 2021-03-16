<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatExceptionRep.aspx.cs" Inherits="Material_MatExceptionRep" Title="ESD" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= ReportsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=ReportsGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewReport" runat="server" Text="Register" Width="80" OnClick="btnNewReport_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="Mats" Width="80" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Search Here" Width="200px" AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="ReportsGridView" runat="server" DataSourceID="MatExceptionDataSource" MasterTableView-EditMode="InPlace"
            OnEditCommand="ReportsGridView_EditCommand" AllowPaging="True" PageSize="30" CellSpacing="-1">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="MatExceptionDataSource" DataKeyNames="EXCP_ID" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this ESD?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="REP_NO" AllowFiltering="false" FilterControlAltText="Filter REP_NO column" HeaderText="ESD REPORT NO" SortExpression="REP_NO" UniqueName="REP_NO" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="REP_DATE" DataType="System.DateTime" FilterControlAltText="Filter REP_DATE column" HeaderText="REPORT DATE" SortExpression="REP_DATE" UniqueName="REP_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" SelectedDate='<%# Bind("REP_DATE") %>' DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REP_DATELabel" runat="server" Text='<%# Eval("REP_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="CREATED_BY" AllowFiltering="false" FilterControlAltText="Filter CREATED_BY column" HeaderText="CREATED BY" SortExpression="CREATED_BY" UniqueName="CREATED_BY" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="MAT_RCV_NO" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MRIR NO" SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="cboMR1" runat="server" AppendDataBoundItems="True" DataSourceID="mrDataSource"
                                DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID" SelectedValue='<%# Bind("MAT_RCV_ID") %>'
                                Width="220px">
                                <Items>
                                    <telerik:DropDownListItem />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="MAT_RCV_NOLabel" runat="server" Text='<%# Eval("MAT_RCV_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" AllowFiltering="false" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" AllowFiltering="false" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
        <asp:HiddenField ID="hiddenScID" runat="server"/>
    </div>

    <asp:ObjectDataSource ID="MatExceptionDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsPO_ShipmentATableAdapters.PIP_MAT_EXCEPTION_REPTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="REP_NO" Type="String" />
            <asp:Parameter Name="REP_DATE" Type="DateTime" />
            <asp:Parameter Name="MAT_RCV_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_EXCP_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_EXCP_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="mrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MIR_ID AS MAT_RCV_ID, MIR_NO AS MAT_RCV_NO FROM PRC_MAT_INSP 
        WHERE (PROJ_ID = :PROJECT_ID) AND MRIR_SC_ID = :MRIR_SC_ID ORDER BY MIR_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="hiddenScID" DefaultValue="-1" Name="MRIR_SC_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
