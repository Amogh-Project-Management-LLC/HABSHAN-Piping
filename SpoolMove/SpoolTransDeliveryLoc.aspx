<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolTransDeliveryLoc.aspx.cs" Inherits="SpoolMove_SpoolTransRegister"
    Title="Spool Delivery Location" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">

        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="locationGridview" runat="server" CellSpacing="-1" DataSourceID="deliveryLocDataSource"
            AllowPaging="True" PageSize="30" MasterTableView-AllowPaging="true" Width="350px">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="deliveryLocDataSource" AllowAutomaticUpdates="true" AllowAutomaticDeletes="true"
                DataKeyNames="DELIVERY_LOCATION">
                <Columns>
                    <telerik:GridBoundColumn DataField="DELIVERY_LOCATION" HeaderText="Delivery Locations"
                        SortExpression="DELIVERY_LOCATION" UniqueName="DELIVERY_LOCATION">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="deliveryLocDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DELIVERY_LOCATION FROM PIP_SRN_DEL_LOCATION WHERE PROJECT_ID = :PROJECT_ID ORDER BY DELIVERY_LOCATION">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
