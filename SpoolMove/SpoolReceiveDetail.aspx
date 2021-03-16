<%@ Page Title="Receive Spools" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolReceiveDetail.aspx.cs" Inherits="SpoolMove_SpoolReceiveDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
           var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
           var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

           var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) + 100+ "px";
            grid.get_element().style.width = width - 20  + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Spool" Width="100px" ></telerik:RadButton>
    </div>
    <div >
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
             AllowPaging="True" PageSize="50" AllowFilteringByColumn="true" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
           <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true">
                        <Selecting AllowRowSelect="True"></Selecting>
                        <Scrolling AllowScroll="True" UseStaticHeaders="True" ></Scrolling>
                    </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" PageSize="50" AllowPaging="true" DataSourceID="itemsDataSource" AllowAutomaticDeletes="true" DataKeyNames="RCV_ID, SPL_ID">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                      <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Confirm Delete" ConfirmTextFormatString="Are you sure you want to delete {0}/{1} ?"
                        ConfirmTextFields="ISO_TITLE1,SPOOL">
                               <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridButtonColumn>
                    
                    <telerik:GridBoundColumn DataField="AREA_L2" FilterControlAltText="Filter AREA_L2 column" HeaderText="AREA" SortExpression="AREA_L2" UniqueName="AREA_L2" FilterControlWidth="80px">
                          <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO TITLE"  SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="220px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL" AllowFiltering="false">
                          <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_REV" FilterControlAltText="Filter SPL_REV column" HeaderText="SPL REV" SortExpression="SPL_REV" UniqueName="SPL_REV" AllowFiltering="false">
                          <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_STORE_NAME" FilterControlAltText="Filter SUB_STORE_NAME column" HeaderText="Sub-Store" SortExpression="SUB_STORE_NAME" UniqueName="SUB_STORE_NAME" FilterControlWidth="80px">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INTERNAL_SUB_STORE_NAME" FilterControlAltText="Filter INTERNAL_SUB_STORE_NAME column" HeaderText="Internal Sub-Store" SortExpression="INTERNAL_SUB_STORE_NAME" UniqueName="INTERNAL_SUB_STORE_NAME" FilterControlWidth="80px">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIFT_SUBSTORE_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter SHIFT_SUBSTORE_DATE column" HeaderText="Internal Sub-Store Date" SortExpression="SHIFT_SUBSTORE_DATE" UniqueName="SHIFT_SUBSTORE_DATE" AllowFiltering="false">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_TYPE" FilterControlAltText="Filter MAT_TYPE column" HeaderText="MAT TYPE" SortExpression="MAT_TYPE" UniqueName="MAT_TYPE" AllowFiltering="false">
                          <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PS" FilterControlAltText="Filter PS column" HeaderText="PS" SortExpression="PS" UniqueName="PS" AllowFiltering="false">
                          <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter WELD_DATE column" HeaderText="WELD DATE" SortExpression="WELD_DATE" UniqueName="WELD_DATE" AllowFiltering="false">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NDE_CMPLT" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter NDE_CMPLT column" HeaderText="NDE CMPLT" SortExpression="NDE_CMPLT" UniqueName="NDE_CMPLT" AllowFiltering="false">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PAINT_CLR" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter PAINT_CLR column" HeaderText="PAINT DATE" SortExpression="PAINT_CLR" UniqueName="PAINT_CLR" AllowFiltering="false">
                          <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSpoolReportsDTableAdapters.VIEW_SPL_RECEIVE_DETAILTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="RCV_ID" QueryStringField="id" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

