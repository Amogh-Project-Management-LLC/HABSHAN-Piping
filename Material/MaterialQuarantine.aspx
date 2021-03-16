<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialQuarantine.aspx.cs" Inherits="Material_MaterialQuarantine" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <telerik:RadButton ID="btnRegister" runat="server" Text="Register" Width="100px"></telerik:RadButton>
        <telerik:RadButton ID="btnMaterial" runat="server" Text="Material" Width="100px" OnClick="btnMaterial_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="100px" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="RadGrid1" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AllowSorting="True"
                    CellSpacing="0" GridLines="None" AutoGenerateColumns="False" DataSourceID="itemstDataSource"
                    PageSize="20" AllowAutomaticDeletes="True" AllowAutomaticUpdates="True">
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                    </ClientSettings>
                    <MasterTableView DataKeyNames="QRNTINE_ID" DataSourceID="itemstDataSource" EditMode="InPlace"
                        EditFormSettings-EditColumn-CancelImageUrl="../App_Themes/BlueTheme/images/cross.png"
                        EditFormSettings-EditColumn-InsertImageUrl="../App_Themes/BlueTheme/images/tick.png"
                        EditFormSettings-EditColumn-ButtonType="ImageButton">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmTextFormatString="Delete {0}?" ConfirmTextFields="QRNTINE_NO" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                                <ItemStyle Width="20px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="QRNTINE_NO" FilterControlAltText="Filter QRNTINE_NO column" HeaderText="Quarantine No" SortExpression="QRNTINE_NO" UniqueName="QRNTINE_NO"
                                CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" ReadOnly="true">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="Sub Contractor" SortExpression="SUB_CON_NAME"
                                UniqueName="SUB_CON_NAME" ReadOnly="true" AllowFiltering="false">
                            </telerik:GridBoundColumn>

                            <telerik:GridDateTimeColumn DataField="CREATE_DATE" FilterControlAltText="Filter CREATE_DATE column"
                                HeaderText="Create Date" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" ReadOnly="true"
                                AllowFiltering="false" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}">
                            </telerik:GridDateTimeColumn>
                            <telerik:GridBoundColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" ReadOnly="true"
                                HeaderText="Create By" SortExpression="CREATE_BY" UniqueName="CREATE_BY" AllowFiltering="false">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="Remarks"
                                SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="False">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:ObjectDataSource ID="itemstDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialDTableAdapters.VIEW_QUARANTINETableAdapter" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_QRNTINE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_QRNTINE_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

