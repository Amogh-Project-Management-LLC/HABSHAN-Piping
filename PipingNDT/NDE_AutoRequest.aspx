<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NDE_AutoRequest.aspx.cs" 
    MasterPageFile="~/MasterPage.master" Inherits="PipingNDT_NDE_AutoRequest" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                 <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add to Request" Width="120" OnClick="btnAdd_Click"></telerik:RadButton>
                </td>
               
               
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="NDEAutoGrid" AutoGenerateColumns="false" DataSourceID="JntsDataSource" runat="server"
            AllowMultiRowSelection="true" AllowFilteringByColumn="true" Height="500">
            <ClientSettings>
                <Scrolling AllowScroll="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView DataKeyNames="JOINT_ID" DataSourceID="JntsDataSource">
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="GridCheckBoxColumn">
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="LINE_NO" HeaderText="Line No" ReadOnly="true" ></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Iso Title" ReadOnly="true" ></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" ReadOnly="true" ></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" ReadOnly="true" ></telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="CRW_CODE" HeaderText="CRW Code" ReadOnly="true" ></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CAT_NAME" HeaderText="Cat Name" ReadOnly="true" ></telerik:GridBoundColumn>
                    
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="JntsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT LINE_NO, ISO_TITLE1, SPOOL, JOINT_NO,JOINT_ID, CAT_ID, CAT_NAME, RT, PT, MT, PWHT, PMI, HT, FT,
                              FAB_SC_ID, FIELD_SC_ID FROM VIEW_NDE_AUTOREQUEST_JNTS 
                       WHERE PROJ_ID = :PROJECT_ID AND 
                              (((CAT_ID = 1 OR  CAT_ID = 3) AND FAB_SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                                OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                             AND (JOINT_ID,:NDE_TYPE_ID) NOT IN (SELECT JOINT_ID,NDE_TYPE_ID FROM VIEW_NDE_REQ_DONE_AUTOREQ)
                             AND (
                                  (:NDE_TYPE_ID=1 AND RT1_REQRD='RT1') OR
                                  (:NDE_TYPE_ID=2 AND RT2_REQRD='RT2') OR
                                  (:NDE_TYPE_ID=3 AND PT_REQRD='PT') OR
                                  (:NDE_TYPE_ID=5 AND MT_REQRD='MT') OR
                                  (:NDE_TYPE_ID=7 AND PWHT_REQRD='PWHT') OR
                                  (:NDE_TYPE_ID=9 AND PMI_REQRD='PMI') OR
                                  (:NDE_TYPE_ID=8 AND HT_REQRD='HT') OR
                                  (:NDE_TYPE_ID=10 AND FT_REQRD='FT') 
                                  )
                       ORDER BY ISO_TITLE1,SPOOL,JOINT_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SC_ID" QueryStringField="SC_ID" />
             <asp:QueryStringParameter DefaultValue="-1" Name="NDE_TYPE_ID" QueryStringField="NDE_TYPE_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
