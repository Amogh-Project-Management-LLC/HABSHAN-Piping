<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"
    Title="Hydro Test Spools" CodeFile="HydroTest_Spools.aspx.cs" Inherits="HydroTest_HydroTestSpools" %>


<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnJnts" runat="server" Text="Joints" Width="80" OnClick="btnJnts_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table runat="server" id="EntryTable" visible="false">

            <tr>
                <td>ISO-Spool
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlSpoolList" runat="server" DataSourceID="newSpoolDataSource" DataTextField="ISO_SPL"
                        DataValueField="SPL_ID" CausesValidation="false" Width="250px"
                        AppendDataBoundItems="true" CheckBoxes="true" AllowCustomText="true" Filter="Contains" EnableCheckAllItemsCheckBox="true">
                    </telerik:RadComboBox>

                </td>
            </tr>
            <tr>
                <td>Remarks</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="spoolsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="HydroSplDataSource" PageSize="12" Width="100%" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" 
            DataKeyNames="SPL_ID,TEST_ID">

            <%-- OnRowUpdating="jointsGridView_RowUpdating" OnRowEditing="jointsGridView_RowEditing"
            OnSelectedIndexChanged="jointsGridView_SelectedIndexChanged"> --%>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                
            </ClientSettings>
            <MasterTableView DataSourceID="HydroSplDataSource" DataKeyNames="SPL_ID,TEST_ID" EditMode="InPlace">

                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmText="Delete?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>


    <asp:SqlDataSource ID="newSpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *FROM VIEW_HYDROTEST_SPL_SRC WHERE SUB_CON_ID=:SC_ID">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="SC_ID" ControlID="hiddenSC" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenSC" runat="server" />
  
    <asp:ObjectDataSource ID="HydroSplDataSource" SelectMethod="GetData" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery" TypeName="dsHydroTestTableAdapters.VIEW_HYDRO_TEST_SPLTableAdapter" runat="server" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TEST_ID" QueryStringField="TEST_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_TEST_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_TEST_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>

</asp:Content>
