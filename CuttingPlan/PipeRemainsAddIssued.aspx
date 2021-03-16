<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipeRemainsAddIssued.aspx.cs" Inherits="CuttingPlan_PipeRemainsAddIssued"
    Title="Pipe Remain" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>
    <div style="margin-top:3px">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="historyGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin" DataSourceID="AddIssuedDataSource" Width="800px">
                    <MasterTableView>
                        <Columns>                            
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="MIV No" SortExpression="ISSUE_NO" />
                            <telerik:GridBoundColumn DataField="ISSUE_DATE" HeaderText="Issue Date" SortExpression="ISSUE_DATE"
                                HtmlEncode="false" DataFormatString="{0:dd-MMM-yyyy}" />
                            <telerik:GridBoundColumn DataField="ISSUED_QTY" HeaderText="Issued Qty" SortExpression="ISSUED_QTY" />
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="AddIssuedDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT REM_ID, ISSUE_NO, ISSUE_DATE, ISSUED_QTY, REMARKS FROM VIEW_ADD_ISSUE_REM_REP WHERE (REM_ID = :REM_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REM_ID" QueryStringField="REM_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
