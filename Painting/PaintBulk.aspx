<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PaintBulk.aspx.cs" Inherits="Painting_PaintBulk" Title="Paint Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="Register" Width="80"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Materials" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%" align="right">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px"
                        AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top: 3px">
        <telerik:RadGrid ID="LooseIssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="PAINT_ID" DataSourceID="LooseIssueDataSource" 
            PageSize="20" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="LooseIssueGridView_DataBound"
            AllowAutomaticUpdates="True">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="PAINT_ID" EditMode="InPlace">
                <Columns>                  
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="PAINT_REQ_NO" HeaderText="Request No" SortExpression="PAINT_REQ_NO" />
                    <telerik:GridTemplateColumn DataField="REQ_DATE" FilterControlAltText="Filter REQ_DATE column" HeaderText="Request Date" SortExpression="REQ_DATE" UniqueName="REQ_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtEditReqDate" runat="server" SelectedDate='<%# Bind("REQ_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REQ_DATELabel" runat="server" Text='<%# Eval("REQ_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="TARGET_DATE" FilterControlAltText="Filter TARGET_DATE column" HeaderText="Target Date" SortExpression="TARGET_DATE" UniqueName="TARGET_DATE">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtEditTargDate" runat="server" DbSelectedDate='<%# Bind("TARGET_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy" Width="150px">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="TARGET_DATELabel" runat="server" Text='<%# Eval("TARGET_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="FROM_SUBCON" HeaderText="From Subcon" SortExpression="FROM_SUBCON" HtmlEncode="false" FilterControlAltText="Filter FROM_SUBCON column" ReadOnly="True" UniqueName="FROM_SUBCON" />
                    <telerik:GridBoundColumn DataField="TO_SUBCON" HeaderText="To Subcon" SortExpression="TO_SUBCON" HtmlEncode="false" FilterControlAltText="Filter TO_SUBCON column" ReadOnly="True" UniqueName="TO_SUBCON" />                                  
                  <%--  <telerik:GridBoundColumn DataField="JC_PAINT_CODE" HeaderText="Paint Code" SortExpression="JC_PAINT_CODE">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="MAT_SCOPE_CODE" HeaderText="Scope" SortExpression="MAT_SCOPE_CODE" />    
                    <telerik:GridBoundColumn DataField="ISSUE_BY" HeaderText="Issue By" SortExpression="ISSUE_BY" ReadOnly="true" />                    
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />

                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>

        </telerik:RadGrid>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>

                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="80" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="80" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <asp:DropDownList ID="ddReports" runat="server" Width="400px">
                        <asp:ListItem Selected="True" Value="4" Text="Paint Request Summary"></asp:ListItem>
                       <%-- <asp:ListItem Value="4.1" Text="Paint Request Summary (BF)"></asp:ListItem>--%>
                      <%--  <asp:ListItem Value="5" Text="Material Issue Voucher"></asp:ListItem>
                        <asp:ListItem Value="7" Text="Material Return After Paint"></asp:ListItem>--%>
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Button ID="btnPreview" runat="server" Text="Preview" Width="78px" BackColor="PowderBlue"
                        BorderColor="SteelBlue" EnableViewState="False" OnClick="btnPreview_Click" />
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="LooseIssueDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsPaintingMatTableAdapters.VIEW_PAINTING_MATTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PAINT_REQ_NO" Type="String" />
            <asp:Parameter Name="REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="JC_PAINT_CODE" Type="String" />
            <asp:Parameter Name="GROUP_ID" Type="Decimal" />
            <asp:Parameter Name="TARGET_DATE" Type="DateTime" />
            <asp:Parameter Name="CMS_RECEIVED_DATE" Type="DateTime" />
            <asp:Parameter Name="MAT_SCOPE_CODE" Type="String" />
            <asp:Parameter Name="Original_PAINT_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="PAINT_REQ_NO" PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="Group_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT GROUP_ID, GROUP_NAME FROM PIP_FAB_GROUP ORDER BY GROUP_NAME"></asp:SqlDataSource>
</asp:Content>
