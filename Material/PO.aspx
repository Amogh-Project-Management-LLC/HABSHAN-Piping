<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="PO.aspx.cs" Inherits="Material_PO" Title="Purchase Order" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="New" Width="80px"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="View Items" Width="90px" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:ImageButton ID="ImageButtonPreview" runat="server" ImageUrl="~/Images/icons/printer.png" OnClick="ImageButtonPreview_Click" />
                </td>
                <td>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Import.." Width="80px"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdateETA" runat="server" Text="Import ETA" Width="100px" OnClick="btnUpdateETA_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMiller" runat="server" Text="Miller Status" Width="120px" OnClick="btnMiller_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUnderSrn" runat="server" Text="Under SRN" Width="120px" OnClick="btnUnderSrn_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="100px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>

        <telerik:RadGrid ID="PO_GridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            PageSize="12" Width="100%" OnDataBound="PO_GridView_DataBound"
            DataKeyNames="PO_ID" ClientDataKeyNames="PO_ID" DataSourceID="PO_DataSource" OnRowUpdating="PO_GridView_RowUpdating" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True">
            <ClientSettings>
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="PO_DataSource" EditMode="InPlace" DataKeyNames="PO_ID">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete PO" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>


                    <telerik:GridBoundColumn DataField="PO_NO" HeaderText="PO No" SortExpression="PO_NO" ItemStyle-Width="100px" />
                    <telerik:GridBoundColumn DataField="PO_TITLE" HeaderText="PO Title" SortExpression="PO_TITLE" />
                    <telerik:GridBoundColumn DataField="PO_DATE" HeaderText="PO Date" SortExpression="PO_DATE" ItemStyle-Width="80px"
                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                    <telerik:GridTemplateColumn HeaderText="PO AMD" SortExpression="PO_AMD">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("PO_AMD") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("PO_AMD") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MANUFACTURE" HeaderText="Manufacture" SortExpression="MANUFACTURE" />
                    <telerik:GridTemplateColumn HeaderText="Origin Country" SortExpression="ORIGIN_COUNTRY">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ORIGIN_COUNTRY") %>' Width="50px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("ORIGIN_COUNTRY") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="PO Terms" SortExpression="PO_TERMS">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("PO_TERMS") %>' Width="80px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("PO_TERMS") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="PO Place" SortExpression="PO_PLACE">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("PO_PLACE") %>' Width="80px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("PO_PLACE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="PO_DataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsPO_ShipmentTableAdapters.PIP_POTableAdapter"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_PO_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PO_NO" Type="String" />
            <asp:Parameter Name="PO_DATE" Type="DateTime" />
            <asp:Parameter Name="PO_TITLE" Type="String" />
            <asp:Parameter Name="PO_AMD" Type="String" />
            <asp:Parameter Name="MANUFACTURE" Type="String" />
            <asp:Parameter Name="ORIGIN_COUNTRY" Type="String" />
            <asp:Parameter Name="PO_TERMS" Type="String" />
            <asp:Parameter Name="PO_PLACE" Type="String" />
            <asp:Parameter Name="Original_PO_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="posplitDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_PO_SPLIT_ADAPTER WHERE  (PROJECT_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="underSRNDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_PO_SPLIT_ADAPTER WHERE  (PROJECT_ID = :PROJECT_ID) AND  SRN_NO IS NOT NULL AND   VIEW_PO_SPLIT_ADAPTER.SRN_NO NOT IN (SELECT DISTINCT SRN_NO FROM PRC_MAT_INSP_DETAIL)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
