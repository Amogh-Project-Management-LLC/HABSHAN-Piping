<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PipeRemains.aspx.cs" Inherits="CuttingPlan_PipeRemains" Title="Pipe Remains" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnHistory" runat="server" Text="History" Width="80" OnClick="btnHistory_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddIssued" runat="server" Text="Add Issued" Width="90" OnClick="btnAddIssued_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnResgister" runat="server" Text="New" Width="90" OnClick="btnResgister_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true"
                        EmptyMessage="Search Here" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="110px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="remainGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="REM_ID" DataSourceID="remainDataSource" SkinID="GridViewSkin"
            PageSize="12" Width="100%" OnDataBound="remainGridView_DataBound">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView DataKeyNames="REM_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
            <Columns>
                <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>                
                           
                <telerik:GridBoundColumn DataField="REM_SERIAL" HeaderText="Remain Serial" ReadOnly="True"
                    SortExpression="REM_SERIAL" />
                <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="Issue No" SortExpression="ISSUE_NO"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Material Code" SortExpression="MAT_CODE1"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="Size" ReadOnly="True" SortExpression="SIZE_DESC" />
                <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="Wall Thick" ReadOnly="True" SortExpression="WALL_THK" />
                <telerik:GridTemplateColumn HeaderText="Heat No" SortExpression="HEAT_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("HEAT_NO") %>' Width="80px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="PS" SortExpression="PS">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PS") %>' Width="40px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("PS") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Length" SortExpression="LENGTH">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("REM_LEN") %>' Width="60px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("REM_LEN") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Theta" SortExpression="PIPE_THETA">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox344" runat="server" Text='<%# Bind("PIPE_THETA") %>' Width="40px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label444" runat="server" Text='<%# Eval("PIPE_THETA") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" ReadOnly="True" SortExpression="UOM" />
                <telerik:GridTemplateColumn HeaderText="Disable" SortExpression="DISABLED">
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDsbl" runat="server" Text='<%# Bind("DISABLED") %>' Width="30px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("DISABLED") %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
                </MasterTableView>
        </telerik:RadGrid>
    </div>

    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="remainDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsCuttingPlanTableAdapters.PIP_PIPE_REMAINTableAdapter" OldValuesParameterFormatString="original_{0}"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="PS" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="REM_LEN" Type="Decimal" />
            <asp:Parameter Name="DISABLED" Type="String" />
            <asp:Parameter Name="PIPE_THETA" Type="Decimal" />
            <asp:Parameter Name="FAB_SHOP_ID" Type="Decimal" />
            <asp:Parameter Name="FAB_GROUP_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_REM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
</asp:Content>