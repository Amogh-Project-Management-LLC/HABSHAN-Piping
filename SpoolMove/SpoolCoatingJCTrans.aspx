<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingJCTrans.aspx.cs" Inherits="SpoolMove_SpoolCoatingJCTrans" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <asp:RadioButtonList ID="radAddOptions" runat="server" RepeatDirection="Horizontal"
                                OnSelectedIndexChanged="radAddOptions_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Text="New Transfer Note" Value="NEW"></asp:ListItem>
                                <asp:ListItem Text="Add to Existing Transfer Note" Value="APPEND"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="cboTransferList" runat="server" Width="250px" Visible="False" DataSourceID="sqlTransferNote"
                                DataTextField="TRANS_NO" DataValueField="TRANS_ID" Filter="Contains">
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" Enabled="false" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>


            <div style="margin-top: 3px">
                <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlItemsDataSource" GridLines="None"
                    AutoGenerateColumns="false" ClientSettings-Scrolling-AllowScroll="true" Height="500px">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <MasterTableView DataSourceID="sqlItemsDataSource" DataKeyNames="SPL_ID">
                        <Columns>
                            <telerik:GridTemplateColumn UniqueName="Check_Col">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="CheckBox1" Checked="true" />
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="COAT_JC_NO" HeaderText="Coat JC No" UniqueName="COAT_JC_NO"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="ISO TITLE" UniqueName="ISO_TITLE1"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="SPOOL" UniqueName="SPOOL"></telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sqlTransferNote" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TRANS_NO, TRANS_ID 
FROM PIP_SPL_TRANSFER
WHERE TO_SC = (SELECT SC_ID FROM PIP_COATING_JC WHERE JC_ID = :TRANS_ID)
AND  FROM_SC = (SELECT FROM_SC FROM PIP_COATING_JC WHERE JC_ID = :TRANS_ID)
AND TRANS_ID NOT IN (SELECT TRANS_ID FROM PIP_SPL_RECEIVE)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="JC_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlItemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VIEW_COATING_JC_SPL.JC_ID, COAT_JC_NO, VIEW_COATING_JC_SPL.SPL_ID, ISO_TITLE1, SPOOL 
FROM VIEW_COATING_JC_SPL INNER JOIN VIEW_ADAPTER_COATING_JC
ON VIEW_COATING_JC_SPL.JC_ID = VIEW_ADAPTER_COATING_JC.JC_ID LEFT OUTER JOIN
PIP_SPL_TRANSFER_DETAIL ON VIEW_ADAPTER_COATING_JC.COAT_JC_NO = PIP_SPL_TRANSFER_DETAIL.DOC_NO
AND VIEW_COATING_JC_SPL.SPL_ID = PIP_SPL_TRANSFER_DETAIL.SPL_ID
WHERE PIP_SPL_TRANSFER_DETAIL.DOC_NO IS NULL 
AND VIEW_COATING_JC_SPL.JC_ID = :JC_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

