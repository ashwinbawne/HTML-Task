namespace RegistrationPage1.Models
{
    public class PagingData
    {

        public List<Reg> Data { get; set; }
        public int TotalRecords { get; set; }
        public int RecordsPerPage { get; set; }
        public int CurrentPage { get; set; }
        public string SearchTerm { get; set; }

        public string FilterText { get; set; }



    }
}
