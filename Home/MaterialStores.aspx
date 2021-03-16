<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStores.aspx.cs" Inherits="Material_Stores" Title="Stores" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            Text="Back" Width="80px" OnClick="btnBack_Click" />
        <telerik:RadButton ID="btnSubstore" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            OnClick="btnSubstore_Click" Text="Substores" Width="85px" />
        <telerik:RadButton ID="btnRegister" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
            OnClick="btnRegister_Click" Text="Register" Width="85px" />
    </div>
    <table style="width: 100%">
        <tr>
            <td>
                <telerik:RadGrid ID="storeGridView" runat="server" AutoGenerateColumns="False" CssClass="DataWebControlStyle"
                    DataSourceID="StoreDataSource" AllowPaging="True" Width="100%" DataKeyNames="STORE_ID"
                    OnRowUpdating="storeGridView_RowUpdating" OnRowEditing="storeGridView_RowEditing" AllowAutomaticUpdates="True" AllowAutomaticDeletes="True"
                    PageSize="13">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True"></Selecting>
                    </ClientSettings>
                    <MasterTableView EditMode="InPlace" DataKeyNames="STORE_ID">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle CssClass="MyImageButton" Width="10px" />
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete PO" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                            </telerik:GridButtonColumn>

                            <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="JOB_CODE" HeaderText="Job Code" ReadOnly="True" SortExpression="JOB_CODE" />
                            <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                        Width="129px">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' Width="129px"></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="LOCATION" HeaderText="Location" SortExpression="LOCATION">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>

                </telerik:RadGrid>
            </td>
        </tr>
    </table><asp:HiddenField ID="hiddenSubConName" runat="server" />
    <asp:ObjectDataSource ID="StoreDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsMaterialATableAdapters.STORES_DEFTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_STORE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="STORE_NAME" Type="String" />
            <asp:Parameter Name="LOCATION" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="Original_STORE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="hiddenSubConName" DefaultValue="%" Name="SUB_CON_NAME" PropertyName="Value" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
