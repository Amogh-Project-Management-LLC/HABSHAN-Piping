<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CustomReport.aspx.cs" Inherits="Home_Home" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            var $ = $telerik.$;
            function exportPDF() {
                $find('<%=RadClientExportManager1.ClientID%>').exportPDF($("#RadPivotGrid"));
            }
            </script>
         </telerik:RadCodeBlock>
     <telerik:RadClientExportManager runat="server" ID="RadClientExportManager1">
    </telerik:RadClientExportManager>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="RadPivotGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadPivotGrid1"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <asp:ImageButton ID="Button1" runat="server" ImageUrl="~/Images/Excel_BIFF.png" Height="20px" Width="20px"  OnClick="ButtonExcel_Click" AlternateText="Biff" />
    <asp:ImageButton ID="Button2" runat="server" ImageUrl="~/Images/Excel_XLSX.png"  Height="20px" Width="20px"  OnClick="ButtonExcel_Click" AlternateText="Xlsx" />
    <asp:ImageButton ID="Button3" runat="server" ImageUrl="~/Images/Word_DOCX.png"  Height="20px" Width="20px"  OnClick="ButtonWord_Click" AlternateText="Docx" />
    <telerik:RadButton runat="server" ID="btnImport" Visible="true" OnClientClicked="exportPDF" AutoPostBack="false">
             <Icon PrimaryIconUrl="../Images/pdf.png" />
    </telerik:RadButton>
    <telerik:RadComboBox AutoPostBack="true" runat="server" ID="RadComboBoxPosition"
        OnSelectedIndexChanged="RadComboBoxPosition_SelectedIndexChanged"
        Label="Position" Size="Narrow">
        <Items>
            <telerik:RadComboBoxItem Text="FieldsWindow" Value="FieldsWindow" />
            <telerik:RadComboBoxItem Text="Left" Value="Left"  />
            <telerik:RadComboBoxItem Text="Top" Value="Top" />
            <telerik:RadComboBoxItem Text="Right" Value="Right" Selected="true" />
            <telerik:RadComboBoxItem Text="Bottom" Value="Bottom" />
        </Items>
    </telerik:RadComboBox>
    <asp:CheckBox ID="CheckBoxEnableDragDrop" runat="server" AutoPostBack="true" Checked="true" Text="Drag-Drop"
        OnCheckedChanged="CheckBoxEnableDragDrop_CheckedChanged" />

    <asp:CheckBox ID="CheckBoxEnableFieldsContextMenu" runat="server" AutoPostBack="true" Checked="true" Text="Fields Context Menu"
        OnCheckedChanged="CheckBoxEnableFieldsContextMenu_CheckedChanged" />
    <asp:CheckBox ID="CheckBox1" runat="server" Text="Disable Paging"></asp:CheckBox>

    <telerik:RadButton RenderMode="Lightweight" ID="saveBtn" Text="Save Report" runat="server" Width="100px" OnClick="saveBtn_Click">
    </telerik:RadButton>
    <telerik:RadButton RenderMode="Lightweight" ID="loadBtn" Text="Load Report" runat="server" Width="100px" OnClick="loadBtn_Click">
    </telerik:RadButton>

    <asp:HiddenField runat="server" ID="SessionID" />
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="RadPivotGrid1" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div id="RadPivotGrid">
    <telerik:RadPivotGrid RenderMode="Lightweight" ID="RadPivotGrid1" runat="server" DataSourceID="SqlDataSource1"
        AllowPaging="True" PageSize="18" ShowFilterHeaderZone="False" ShowDataHeaderZone="False" ShowRowHeaderZone="False"
        ShowColumnHeaderZone="False" EnableConfigurationPanel="True" AllowSorting="True" EmptyValue="0">
        <ConfigurationPanelSettings Position="Right" DefaultDeferedLayoutUpdate="true" ShowHideCheckBoxToolTip="true"  />
       
        <ClientSettings>
            
        </ClientSettings>
        
        
        <TotalsSettings GrandTotalsVisibility="ColumnsOnly" RowsSubTotalsPosition="Last"  />
        
    </telerik:RadPivotGrid>
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"> 
    </asp:SqlDataSource>
    
</asp:Content>

