<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SpoolCoatingUpdate.aspx.cs" Inherits="SpoolMove_SpoolCoatingUpdate" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnUpdate" runat="server" Text="Update Report" Width="120px"></telerik:RadButton>
        <telerik:RadDropDownList ID="ddlCoatingTypeList" runat="server" AutoPostBack="True" DataSourceID="sqlCoatingType"
            DataTextField="COATING_TYPE" DataValueField="COATING_TYPE_ID" AppendDataBoundItems="true"
            OnDataBinding="ddlCoatingTypeList_DataBinding" Width="200px" OnSelectedIndexChanged="ddlCoatingTypeList_SelectedIndexChanged">
        </telerik:RadDropDownList>
        <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search.." AutoPostBack="True" Width="200px">
        </telerik:RadTextBox>
    </div>
    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="Both">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="JC_ID, SPL_ID"
                        AllowAutomaticUpdates="true">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="30px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" ReadOnly="true" FilterControlAltText="Filter ISO_TITLE1 column" HeaderText="ISO TITLE" SortExpression="ISO_TITLE1" UniqueName="ISO_TITLE1">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPOOL" ReadOnly="true" FilterControlAltText="Filter SPOOL column" HeaderText="SPOOL" SortExpression="SPOOL" UniqueName="SPOOL">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SPL_SIZE" ReadOnly="true" FilterControlAltText="Filter SPL_SIZE column" HeaderText="SPL SIZE" SortExpression="SPL_SIZE" UniqueName="SPL_SIZE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PS" ReadOnly="true" FilterControlAltText="Filter PS column" HeaderText="PAINT SYS" SortExpression="PS" UniqueName="PS">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="COAT_REP_NO" FilterControlAltText="Filter COAT_REP_NO column" HeaderText="COATING REP NO" SortExpression="COAT_REP_NO" UniqueName="COAT_REP_NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="COAT_REP_NOTextBox" runat="server" Text='<%# Bind("COAT_REP_NO") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="COAT_REP_NOLabel" runat="server" Text='<%# Eval("COAT_REP_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="COAT_REP_DT" FilterControlAltText="Filter COAT_REP_DT column" HeaderText="COATING REP DT" SortExpression="COAT_REP_DT" UniqueName="COAT_REP_DT">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="COAT_REP_DTTextBox" runat="server" DbSelectedDate='<%# Bind("COAT_REP_DT") %>' Width="120px"
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="COAT_REP_DTLabel" runat="server" Text='<%# Bind("COAT_REP_DT", "{0:dd-MMM-YYYY}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="BLAST_REP_NO" FilterControlAltText="Filter BLAST_REP_NO column" HeaderText="BLAST REP NO" SortExpression="BLAST_REP_NO" UniqueName="BLAST_REP_NO">
                                <EditItemTemplate>
                                    <asp:TextBox ID="BLAST_REP_NOTextBox" runat="server" Text='<%# Bind("BLAST_REP_NO") %>' Width="100px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="BLAST_REP_NOLabel" runat="server" Text='<%# Eval("BLAST_REP_NO") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="BLAST_REP_DT" DataType="System.DateTime" FilterControlAltText="Filter BLAST_REP_DT column" HeaderText="BLAST REP DT" SortExpression="BLAST_REP_DT" UniqueName="BLAST_REP_DT">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="BLAST_REP_DTTextBox" runat="server" DbSelectedDate='<%# Bind("BLAST_REP_DT") %>' Width="120px"
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="BLAST_REP_DTLabel" runat="server" Text='<%# Eval("BLAST_REP_DT") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="COATING_TYPE" FilterControlAltText="Filter COATING_TYPE column" HeaderText="COATING TYPE" SortExpression="COATING_TYPE" UniqueName="COATING_TYPE" ReadOnly="True">
                            </telerik:GridBoundColumn>
                        </Columns>

                        <EditFormSettings>
                            <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPaintingRepsTableAdapters.VIEW_SPL_COATING_REPORTTableAdapter" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCoatingTypeList" DefaultValue="-1" Name="TYPE_ID" PropertyName="SelectedValue" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="ISO_TITLE1" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="COAT_REP_NO" Type="String" />
            <asp:Parameter Name="COAT_REP_DT" Type="String" />
            <asp:Parameter Name="BLAST_REP_NO" Type="String" />
            <asp:Parameter Name="BLAST_REP_DT" Type="DateTime" />
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlCoatingType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM PIP_COATING_TYPE"></asp:SqlDataSource>
</asp:Content>

