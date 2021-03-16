<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SiteAssemblyJC.aspx.cs" Inherits="MatIssueLoose" Title="Loose Material Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnNewIssue" runat="server" Text="Register" Width="84px" OnClick="btnNewIssue_Click" />
                        </td>
                         <td>
                            <telerik:RadButton ID="btnJoints" runat="server" Text="Joints" Width="81px" OnClick="btnJoints_Click"/>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnViewMats" runat="server" OnClick="btnViewMats_Click" Text="Materials" Visible="false"
                                Width="81px" />
                        </td>
                      <%--  <td>
                            <telerik:RadButton ID="btnSpools" runat="server" Text="Spools" Width="81px" OnClick="btnSpools_Click" />
                        </td>--%>
                        
                        <td>
                            <telerik:RadButton ID="btnUpdate" runat="server" Text="Flange Status" Width="100px" OnClick="btnUpdate_Click" Visible="false"/>
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
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="LooseIssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="JC_ID" DataSourceID="LooseIssueDataSource"
                    PageSize="15" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="LooseIssueGridView_DataBound">
                    <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                    <MasterTableView DataKeyNames="JC_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="Issue Number" SortExpression="ISSUE_NO" />
                            <telerik:GridBoundColumn DataField="PCWBS" HeaderText="PCWBS" SortExpression="PCWBS" />
                            <%--<telerik:GridBoundColumn DataField="MAT_TYPE" HeaderText="Material" SortExpression="MAT_TYPE" />     --%>
                            <telerik:GridBoundColumn DataField="JC_TYPE" HeaderText="JC Type" SortExpression="JC_TYPE" ReadOnly="true" /> 
                            <telerik:GridTemplateColumn HeaderText="Issue Date" SortExpression="ISSUE_DATE">
                                <edititemtemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="82px"></asp:TextBox>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'
                                    Width="82px"></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_BY" HeaderText="Issued by" SortExpression="ISSUE_BY" />
                            <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                                <edititemtemplate>
                                <asp:DropDownList ID="DropDownList4" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                    DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                    Width="127px">
                                    <asp:ListItem Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                            </edititemtemplate>
                                <itemtemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' Width="127px"></asp:Label>
                            </itemtemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>

                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="84px" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="41px" OnClick="btnYes_Click" EnableViewState="False" Visible="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="41px" EnableViewState="False" Visible="False" />
                        </td>
                        <td style="width: 100%" align="right">
                            <telerik:RadDropDownList ID="ddReports" runat="server" Width="400px">
                                <Items>
                                    <telerik:DropDownListItem Selected="True" Value="20" Text="Flange Jobcard "></telerik:DropDownListItem>
                                    <%--<telerik:DropDownListItem Selected="True" Value="6" Text="Jobcard Transmittal"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="3" Text="Request for Field Installation - Isometric"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="2" Text="Fastner Pick Ticket - JC Wise"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="12" Text="Material Pick Ticket - Isometric Wise"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="10" Text="Fabrication Spool List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="11" Text="Erection Support List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="7" Text="Flange Joint List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="1" Text="Spool Cleaning Rec"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="4" Text="Punch List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="5" Text="Remaining Work List (Blank)"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="15" Text="Remaining Work List (With Data)"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="13" Text="Field Material List for Field Installation"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="14" Text="Material Shortage Report"></telerik:DropDownListItem>--%>
                                </Items>
                            </telerik:RadDropDownList>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="78px" EnableViewState="False" OnClick="btnPreview_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="LooseIssueDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsErectionTableAdapters.VIEW_SITE_JC_ASSEMBLYTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="ISSUE_BY" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="PCWBS" Type="String" />
           <%-- <asp:Parameter Name="MAT_TYPE" Type="String" />--%>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="ISSUE_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
