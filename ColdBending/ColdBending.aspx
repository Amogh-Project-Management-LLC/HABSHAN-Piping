<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="ColdBending.aspx.cs" Inherits="ColdBending_ColdBending" Title="Cold Bending" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                  <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New" Width="80" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Materials" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
               
              
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="LooseIssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="JC_ID" DataSourceID="LooseIssueDataSource" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            PageSize="20" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="LooseIssueGridView_DataBound">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataSourceID="LooseIssueDataSource" DataKeyNames="JC_ID" EditMode="InPlace">
                <Columns>

                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete this MIV Transmittal?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="JC_NO" HeaderText="Jobcard No" SortExpression="JC_NO" />
                    <telerik:GridBoundColumn DataField="ISSUE_DATE" HeaderText="Issue Date" SortExpression="ISSUE_DATE"
                        DataFormatString="{0:dd-MMM-yyyy}"  EditFormHeaderTextFormat="true" HtmlEncode="false" />
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME"
                        ReadOnly="true" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
               

                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="ddReports" runat="server" Width="250px">
                        <asp:ListItem Selected="True" Value="1" Text="Cool Bending JC"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Material Pick Ticket"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Paint Request"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="LooseIssueDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsCoolBendingTableAdapters.VIEW_COOL_BENDING_JCTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="JC_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="JC_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
