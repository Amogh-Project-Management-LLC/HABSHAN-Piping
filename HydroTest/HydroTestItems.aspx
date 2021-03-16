<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HydroTestItems.aspx.cs" Inherits="HydroTest_HydroTestItems" Title="Hydro Test" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
            
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="jointsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="JntsDataSource" PageSize="18" Width="100%"  AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
            <ClientSettings>
                <Selecting AllowRowSelect="true"/>
            </ClientSettings>
            <MasterTableView DataSourceID="JntsDataSource">
                 
            <Columns>
                 
                <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="True" />
                <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="True" />
                <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="CRW_CODE" HeaderText="CR" SortExpression="CRW_CODE" ReadOnly="True" />
                <telerik:GridBoundColumn DataField="JNT_REV" HeaderText="Rev-Code" SortExpression="JNT_REV"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="JOINT_SIZE" HeaderText="Joint Size" SortExpression="JOINT_SIZE"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="JOINT_TYPE" HeaderText="Joint Type" SortExpression="JOINT_TYPE"
                    ReadOnly="True" />
                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>
                </MasterTableView>
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="JntsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsHydroTestTableAdapters.VIEW_HYDRO_TEST_SPL_JNTSTableAdapter">     
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="SPL_ID" QueryStringField="SPL_ID"
                Type="Decimal" />
        </SelectParameters>      
    </asp:ObjectDataSource>
  
</asp:Content>