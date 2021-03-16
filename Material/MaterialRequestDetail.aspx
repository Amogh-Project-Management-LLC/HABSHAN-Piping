<%@ Page Title="Material Request Items" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequestDetail.aspx.cs" Inherits="Material_MaterialRequestDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=RadGrid1.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div>
        <telerik:RadButton runat="server" ID="btnBack" Width="80px" Text="Back" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAdd" Width="120px" Text="Add Material"></telerik:RadButton>
        <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
            EmptyMessage="Search Material Code" Width="200px" AutoPostBack="True">
        </telerik:RadTextBox>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="itemstDataSource" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemstDataSource" EditMode="InPlace" DataKeyNames="MAT_REQ_ID, MAT_ID">
                <Columns>
                    <telerik:GridButtonColumn CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTextFormatString="Are you sure you want to delete {0}?"
                        ConfirmTextFields="MAT_CODE1" ConfirmTitle="Confirm Delete">
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE_DESC" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REQ_QTY" DataType="System.Decimal" FilterControlAltText="Filter REQ_QTY column" HeaderText="REQ_QTY" SortExpression="REQ_QTY" UniqueName="REQ_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RQRD_DATE" DataType="System.DateTime" FilterControlAltText="Filter RQRD_DATE column" HeaderText="RQRD_DATE" SortExpression="RQRD_DATE" UniqueName="RQRD_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" SelectedDate='<%# Bind("RQRD_DATE") %>'></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RQRD_DATELabel" runat="server" Text='<%# Eval("RQRD_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="RQRD_LOCATION" FilterControlAltText="Filter RQRD_LOCATION column" HeaderText="RQRD_LOCATION" SortExpression="RQRD_LOCATION" UniqueName="RQRD_LOCATION">
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

    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialATableAdapters.VIEW_MATERIAL_REQUEST_DTTableAdapter" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_REQ_ID" QueryStringField="MAT_REQ_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_MAT_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REQ_QTY" Type="Decimal" />
            <asp:Parameter Name="RQRD_DATE" Type="DateTime" />
            <asp:Parameter Name="RQRD_LOCATION" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_MAT_REQ_ID" Type="Decimal" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

