<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_SpoolClearance.aspx.cs" Inherits="PipingNDT_NDE_ManualRequest" Title="NDT Request" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .MyRowClass {
            background-color: red;
        }

        .MyRowClass2 {
            background-color: green;
        }


    </style>
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Width="80"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add to Request" OnClick="btnAdd_Click" Width="120"></telerik:RadButton>
                </td>


            </tr>
        </table>
    </div>
    <div>
       
                <table style="width: 100%">
                    <tr>
                        <td>
                            <telerik:RadLabel Text="Sub Con" ID="RadLabel1" runat="server"></telerik:RadLabel>
                            <telerik:RadComboBox ID="rcbSubCon" runat="server" CausesValidation="false" Width="250px" DataSourceID="SubConDataSource" DataValueField="SUB_CON_ID" DataTextField="SUB_CON_NAME"
                                AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="rcbSubCon_SelectedIndexChanged" >
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30%">
                            <telerik:RadLabel Text="Line No" ID="lblLine" runat="server"></telerik:RadLabel>
                            <telerik:RadComboBox ID="rcbLineNO" runat="server" CausesValidation="false" Width="250px" DataSourceID="LINEDataSource" DataValueField="line_no" DataTextField="line_no"
                                AppendDataBoundItems="true" CheckBoxes="true" AllowCustomText="true" Filter="Contains" EnableCheckAllItemsCheckBox="true" AutoPostBack="true" OnSelectedIndexChanged="ddlLineNo_SelectedIndexChanged" >
                            </telerik:RadComboBox>
                        </td>


                        <td style="width: 70%;">

                            <ul style="list-style: none;">

                                <li style=" float: left; margin-right: 10px;"><span  style="background-color: white;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Not Requested</li>
                                <li style=" float: left; margin-right: 10px;"><span  style="background-color: yellow;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Requested</li>
                                <li style=" float: left; margin-right: 10px;"><span style="background-color: lightgreen;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Accepted</li>
                                <li style=" float: left; margin-right: 10px;"><span style="background-color: red;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Rejected</li>
                                <li style=" float: left; margin-right: 10px;"><span  style="background-color: lightcoral;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>CRW/Repair</li>
                                 <li style=" float: left; margin-right: 10px;"><span  style="background-color: mediumorchid;border: 1px solid #ccc; float: left; width: 30px; height: 15px; margin: 2px;"></span>Reshoot</li>
                            </ul>

                        </td>
                    </tr>
                </table>
        
                <table style="width: 100%">

                    <tr>
                        <td style="width: 50%">
                            <telerik:RadListBox ID="From_Joints" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" AllowTransfer="True" TransferToID="To_Joints" OnTransferring="From_Joints_Transferring"
                                DataTextField="JNT_TITLE" DataValueField="JOINT_ID" AutoPostBack="true" OnTransferred="From_Joints_Transferred" AutoPostBackOnTransfer="true" >
                            </telerik:RadListBox>
                        </td>
                        <td style="width: 50%">
                            <telerik:RadListBox ID="To_Joints" runat="server" Width="100%" Height="200px" SelectionMode="Multiple" ContentPlaceHolderID="List2"></telerik:RadListBox>
                        </td>
                    </tr>

                </table>


                </div>

    <div>

        <telerik:RadGrid ID="lineGrid" runat="server" AutoGenerateColumns="true" PageSize="10" >
            <ClientSettings >
                <Scrolling AllowScroll="true" UseStaticHeaders="true"/>
                
            </ClientSettings>

        </telerik:RadGrid>
         
    </div>


    <asp:SqlDataSource ID="SubConDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_ID,SUB_CON_NAME   FROM SUB_CONTRACTOR">
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="LINEDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT LINE_NO
                       FROM VIEW_NDE_MANUAL_REQUEST_JNTS
                       WHERE PROJ_ID = :PROJECT_ID AND
                        (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                                OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                          AND  (
                                  ((:NDE_TYPE_ID=1 OR :NDE_TYPE_ID=12) AND RT1_REQRD &gt; 0) OR
                                  ((:NDE_TYPE_ID=2 OR :NDE_TYPE_ID=13) AND RT2_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=3 AND  PT_REQRD &gt; 0 ) OR
                                  (:NDE_TYPE_ID=5 AND MT_REQRD &gt; 0 ) OR
                                  (:NDE_TYPE_ID=7 AND PWHT_REQRD &gt; 0 ) OR
                                  (:NDE_TYPE_ID=9 AND PMI_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=8 AND HT_REQRD &gt; 0 ) OR
                                  (:NDE_TYPE_ID=10 AND FT_REQRD &gt; 0)
                               )
                        ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SC_ID" QueryStringField="SC_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="NDE_TYPE_ID" QueryStringField="NDE_TYPE_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="jntsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ISO_TITLE1||'/'||SPOOL||'/'||JOINT_NO||'/'||CRW_CODE AS JNT_TITLE,JOINT_ID,
                                PROJ_ID, LINE_NO, ISO_TITLE1, ISO_ID, SPOOL, SPL_ID,
                                JOINT_ID, JOINT_NO, CAT_ID, CRW_CODE, JNT_REV_ID, REPAIR_CODE,
                                WO_ID, SC_ID,SHOP_SC, FIELD_SC_ID,FIELD_SC, RT, PT, MT, PWHT, PMI, HT, FT,
                                RT1_REQRD, RT2_REQRD, PT_REQRD, MT_REQRD, PWHT_REQRD,
                                PMI_REQRD, HT_REQRD, FT_REQRD, RT1_RQSTD, RT2_RQSTD,
                                PT_RQSTD, MT_RQSTD, PWHT_RQSTD, PMI_RQSTD, HT_RQSTD,
                                FT_RQSTD, RT1_DONE, RT2_DONE, PT_DONE, MT_DONE, PWHT_DONE,
                                PMI_DONE, HT_DONE, FT_DONE, RT1_REJ, RT2_REJ, PT_REJ, MT_REJ,
                                PWHT_REJ, PMI_REJ, HT_REJ, FT_REJ, RT1_RSHT, RT2_RSHT,
                                PT_RSHT, MT_RSHT, PWHT_RSHT, PMI_RSHT, HT_RSHT, FT_RSHT,
                                RT1_REP_NDE_BAL, RT2_REP_NDE_BAL, PT_REP_NDE_BAL,
                                MT_REP_NDE_BAL, PWHT_REP_NDE_BAL, PMI_REP_NDE_BAL,
                                HT_REP_NDE_BAL, FT_REP_NDE_BAL
                       FROM VIEW_NDE_MANUAL_REQUEST_JNTS
                       WHERE PROJ_ID = :PROJECT_ID AND
                        (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                                OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                         AND  (
                                  ((:NDE_TYPE_ID=1 OR :NDE_TYPE_ID=12) AND RT1_REQRD &gt; 0) OR
                                  ((:NDE_TYPE_ID=2 OR :NDE_TYPE_ID=13) AND RT2_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=3 AND  PT_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=5 AND MT_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=7 AND PWHT_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=9 AND PMI_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=8 AND HT_REQRD &gt; 0) OR
                                  (:NDE_TYPE_ID=10 AND FT_REQRD &gt; 0)  
                               )
                       ">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="SC_ID" QueryStringField="SC_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="NDE_TYPE_ID" QueryStringField="NDE_TYPE_ID" />
         

        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenLineNo" runat="server" />

    <asp:SqlDataSource ID="LineWiseDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>">
        <%--  <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
          
        </SelectParameters>--%>
    </asp:SqlDataSource>
</asp:Content>
