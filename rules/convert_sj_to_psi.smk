import os
####GTF
gtf = "/SAN/vyplab/vyplab_reference_genomes/annotation/human/GRCh38/gencode.v34.annotation.gtf"

####Folders and all the other stuff
####humans
out_spot = "normalized_annotated/"
# input_sj_folder = " /SAN/vyplab/alb_projects/data/sinai_splice_junctions/sinai_all_samples_renamed_sj_tabs/"
sj_suffix = ".SJ.out.tab"
####cell lines
input_sj_folder = "/SAN/vyplab/alb_projects/data/sinai_splice_junctions/all_bams_kds_linked/sj_files_only/"



# =-------DON"T TOUCH ANYTHING PAST THIS POINT ----------------------------
bedops_path = "/SAN/vyplab/alb_projects/tools/bedops/bin/"

output_dir = os.path.join(input_sj_folder,out_spot)
# print(bam_dir)
SAMPLES, = glob_wildcards(bam_dir + "{sample}" + sj_suffix)



rule normalize_annotate:
    input:
        os.path.join(bam_dir + "{sample}" + sj_suffix)
    output:
        os.path.join(bam_dir + "{sample}" + "_normalized_annotated.csv")
    params:
        gtf = config['gtf'],
        output_folder = output_dir
    shell:
        """
        mkdir -p {output_dir}
        Rscript scripts/convert_sj_to_psi.R --sample_name {sample} --sample_file {input} --gtf {params.gtf} --output_folder {params.output_folder}
        """